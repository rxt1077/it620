#import "/templates/exercise.typ": exercise, code, admonition
#import "@preview/cntopo:0.1.0": cetz, fletcher-shapes
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

/* goals and lab-name are used by index.typ
   that's why we define and then pass them to the show rule */
#let lab-name = "WiFi Deauth Attack"
#let outcomes = ("monitor", "build-managed", "deauth")

#show: doc => exercise(
  course-name: "Wireless Network Security and Administration",
  exercise-name: lab-name,
  exercise-type: "Lab",
  outcomes: outcomes,
  doc,
)

== Background

In this lab you will run the aircrack-ng tools on a Mininet-WiFi VM image demonstrate a WiFi deauth attack.

== Installing aircrack-ng

Start the Mininet-WiFi VM the same way you did in the #link("getting-started.pdf")[Getting Started with Mininet-WiFi] and open a terminal.

Run `sudo apt install aircrack-ng` and hit enter or 'y' when prompted to install the packages.

== Creating Traffic

#let (
  monitor,
  w-ap,
) = fletcher-shapes(
  flat: false,
)
#let node = node.with(width: 4em, height: 4em)
#let default-topo = diagram(
  node((1, 0), shape: w-ap.with(detail: "ap1"), name: <ap1>),
  node((0, 1), shape: monitor.with(label: "sta1"), name: <sta1>),
  node((2, 1), shape: monitor.with(label: "sta2"), name: <sta2>),
  edge(<ap1>, <sta1>, dash: "dashed"),
  edge(<ap1>, <sta2>, dash: "dashed"),
)
#figure(
  default-topo,
  caption: "Mininet-WiFi Default Topology",
)

Start the default Mininet-WiFi topology by running `sudo mn --wifi` (the wifi user password is wifi)

Now find the IPv4 address for _sta2_ by running `sta2 ip address show dev sta2-wlan0`.
Don't forget this address!
Remember for an IPv4 address you're looking for 4 dotted decimal integers between 0 and 255.
Don't include the subnet mask and don't use the broadcast address.

Now run `xterm sta1`.
This will open a new terminal window as if it were running on _sta1_.
Now inside the new xterm window run `ping <ADDRESS>` where <ADDRESS> is the IPv4 address of _sta2_ that you found previously.

You now have _sta1_ continuously pinging _sta2_ through _ap1_ in a simulated WiFi network.

== Sending Deauth Frames

From Mininet-WiFi CLI (the one with the mininet-wifi prompt, not the xterm on _sta1_) run the following command to determine what the MAC address of the WiFi interface on _ap1_ is: `ap1 ip link show ap1-wlan1`.
Remember that MAC addresses are typically six hexadecimal bytes separated by colons (':').
Remember this MAC address, it is the BSSID for this WiFi network.

Again from the Mininet-WiFi CLI run the following command to determine what the MAC address of the WiFi interface on _sta1_ is: `sta1 ip link show sta1-wlan0`.
We will call this MAC address STA1-MAC.

Now run `xterm sta2` to open a terminal window as if it were running on _sta2_.
_sta2_ will be our attacker, we will send a deauth frame to disconnect _sta1_ from _ap1_.
Run the following command in this new terminal: `aireplay-ng --deauth=1 -a <BSSID> -c <STA1-MAC>`

== Analysis

Now check the other window.
What responses are your pings getting?
You can stop the ping with Ctrl-C and run `iw dev sta1-wlan0 link` to see the status of your connection to _ap1_.

== Questions

+ What is the connection status of _sta1_ and _sta2_ at the end of this lab?
+ #link("https://www.aircrack-ng.org/doku.php?id=deauthentication")[Why might an attacker use a deauth attack on a WiFi network?]
+ Which part of the #link("https://www.fortinet.com/resources/cyberglossary/cia-triad")[CIA triad] is being targeted by this attack?
+ What mitigation techniques are there for this attack?

When you are done you can close the xterms, type exit in the Mininet-WiFi command line, and Shutdown the machine from the main menu.
