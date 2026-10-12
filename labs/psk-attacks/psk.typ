#import "/templates/exercise.typ": exercise, code, admonition

/* goals and lab-name are used by index.typ
   that's why we define and then pass them to the show rule */
#let lab-name = "PSK Attacks"
#let outcomes = ("monitor", "build-managed", "psk")

#show: doc => exercise(
  course-name: "Wireless Network Security and Administration",
  exercise-name: lab-name,
  exercise-type: "Lab",
  outcomes: outcomes,
  doc,
)

== Background

In this lab you will run the aircrack-ng tools on a Mininet-WiFi VM image demonstrate a attacks against WEP and WPA2 pre-shared keys.

== Installing Setup

Start the Mininet-WiFi VM the same way you did in the #link("getting-started.pdf")[Getting Started with Mininet-WiFi] and open a terminal.
You should already have aircrack-ng installed from the #link("deauth.pdf")[WiFi Deauth Attack] lab.

You will need to clone the class git repo into your VM by running, `git clone https://github.com/rxt1077/it620.git`.
Now you can change into the lab directory with the following command `cd it620/labs/psk-attack`.

== Cracking WEP

Start the WEP Mininet-WiFi topology by running `sudo python3 wep.py` (the wifi user password is wifi).

This topology has three stations (_sta1_, _sta2_, _sta3_) and one access point (_ap1_).
_sta2_ and _sta3_ are connected to _ap1_ with WEP encryption.
_sta1_ is not connected to the access point.
We will use _sta1_ to crack the WEP PSK on the network.

From the Mininet-WiFi CLI, add a monitor interface to station 1 by running `sta1 iw dev sta1-wlan0 interface add mon0 type monitor`.
Now bring the interface up by running `sta1 ip link set dev mon0 up`.

We'll need the BSSID of the access point so we know what packets to capture. You can find it by running `ap1 ip link show ap1-wlan1` and looking for the six colon-separated digits listed after link/ether.
From now on, we'll call that MAC address <BSSID>.

Open an xterm on _sta1_ by running `xterm sta1` and from within that xterm run `airodump-ng -w wepnet --channel 1 --bssid <BSSID> mon0` where <BSSID> is the MAC address you found previously.
_sta1_ is now monitoring frames on our network, storing them to a file, and providing us with an updated list of what it has captured:

#image("/images/airodump-wep.png", alt: "airodump-ng capturing WEP packets", width: 60%)

During an actual attack, the attacker may wait until they've captured around 25,000 packets or they may execute a deauth or ARP attack to cause a spike in traffic.
For our purposes, we will quickly simluate some traffic with a flood ping.
From the Mininet-WiFi CLI, while airodump-ng is still running in an xterm, run `sta2 ping -f sta3`.
You should see more packets being captured as _sta2_ is now flooding _sta3_ with ICMP echo requests.
Once you have about 150,000 packets (ten seconds or so) stop the flood ping by typing #link("https://en.wikipedia.org/wiki/Control-C")[Ctrl-C] in the Mininet-WiFi CLI.

No inside the _sta1_ xterm stop airodump-ng by typing Ctrl-C.
If you list the files in the directory, `ls`, you'll see a cap file of the captured frames: wepnet-01.cap.
Using this, you can perform a statistical attack against RC4 and determine what the PSK is.
Run `aircrack-ng wepnet-01.cap` and you should be able the see the PSK!
Make a note of it.

Now you can bring down the WEP network by typing `exit` in the xterm and in the Mininet-WiFi CLI.

== WPA2 Dictionary Attack

Start the WPA2 Mininet-WiFi topology by running `sudo python3 wpa2.py` (the wifi user password is wifi).

This topology has three stations (_sta1_, _sta2_, _sta3_) and one access point (_ap1_).
_sta2_ and _sta3_ are connected to _ap1_ with WPA2 PSK security and a poor password.
_sta1_ is not connected to the access point.
We will use _sta1_ to determine the network's PSK by capturing a handshake and performing a dictionary attack.

As you did in the previous section, create a monitor interface on _sta1_, start an xterm, and run airodump-ng filtering for the BSSID of _ap1_ but write to the prefix wpa2net instead of wepnet.
Leave this running in an xterm.

Now we will need to simulate a connection to the network.
_sta2_ is currently associated with _ap1_ and the connection is managed via the #link("https://en.wikipedia.org/wiki/Wpa_supplicant")[wpa_supplicant] daemon.
We will send wpa_supplicant a signal telling it we want it to reassociate.
At the Mininet-WiFi CLI, type the following command, `sta2 wpa_cli -i sta2-wlan0 reassociate`.
Give it a few seconds and you should see some EAPOL frames showing up in airodump-ng:

#image("/images/airodump-wpa2.png", alt: "airodump-ng capturing WPA2 EAPOL packets", width: 60%)

Now we will use a list of the 100,000 most common passwords (included in the lab directory) to see if we can find the PSK.
Run the following command, `aircrack-ng -w passwords.txt wpa2net-01.cap` (your filename may differ if you have run airodump-ng multiple times).
After about a minute, you should be able to see the PSK!
Make a note of it.

No you can bring down the WPA2 network by typing `exit` in the xterm and in the Mininet-WiFi CLI.
Then you can close the terminal and shutdown the VM.

== Questions

+ What was the password for the WEP network?
+ What was the password for the WPA2 network?
+ The attack against the WEP network used a cryptographic weakness in RC4. How does that differ from the attack against the WPA2 network?
+ Which attack requires sniffing more traffic?
+ What mitigation techniques are there for these attacks?
