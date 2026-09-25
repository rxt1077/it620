#import "/templates/exercise.typ": exercise, code, admonition

/* goals and exercise-name are used by index.typ
   that's why we define and then pass them to the show rule */
#let exercise-name = "Getting Started with Mininet-WiFi"
#let outcomes = ()

#show: doc => exercise(
  course-name: "Wireless Network Security and Administration",
  exercise-name: exercise-name,
  outcomes: outcomes,
  doc,
)

== Background

In this lab you will use a Mininet-WiFi VM image to run a wireless SDN network emulator and discover the properties of a basic WiFi network.

== Running the VM

If you don't already have it installed, download #link("https://www.virtualbox.org/wiki/Downloads")[VirtualBox] for your platform.
You will also need to download the #link("https://drive.google.com/file/d/1nFSdLKqoeEeGkJQ6GZIntbKxLkN52pmJ/view?usp=sharing")[OVA file for the Mininet-WiFi VM] (I know it's huge, but we'll reuse it).
Once downloaded, import the file into VirtualBox (File->Import Appliance).
Start the machine and after it boots you will see the Lubuntu Desktop.

== Running Mininet-WiFi

Click the menu in the bottom left and open a terminal (System Tools->QTerminal).
In the terminal run `sudo mn --wifi` (the wifi user password is wifi).

#image("/images/lab3-1.png")

By default Mininet-WiFi creates three nodes: Two stations and one access point.
This is a very basic WiFi network utilizing managed mode.
From the Mininet-WiFi command line you can run Linux commands as any station or access point.

For example, try running `sta1 ping -c sta2`.
You should see three ping responses from sta2.

== Adding a Monitor Interface to sta1

If we want to see all of the traffic that a node in our network sees, we'll need to add a monitor interface.
We can do this from the command line with the following commands:

`sta1 iw dev sta1-wlan0 interface add mon0 type monitor`

This basically says, "Run the iw command on sta1 and tell it that I want to add a monitor device to the sta1-wlan0 interface."

Next we run `sta1 ip link set mon0 up` which uses the ip command on sta1 to bring the monitor interface up.

#image("/images/lab3-2.png")

== Running Wireshark on sta1

Now try running `sta1 wireshark &`
This should start the Wireshark Network Analyzer as if it is running on sta1.

Double-click on mon0 to start capturing on that interface.
You can hit the red stop square in the upper-left corner after you grab a few frames (you probably have more than a few at this point).

#image("/images/lab3-3.png")

== Questions

Use the information in the Wireshark packets to answer the following questions for this lab:

+ What kind of frames are you seeing?
+ What is the MAC address of the AP (BSS Id)?
+ What is the SSID of the WiFi network?

When you are done you can close Wireshark, type exit in the Mininet-WiFi command line, and Shutdown the machine from the main menu.  
