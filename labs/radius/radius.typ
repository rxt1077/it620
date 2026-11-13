#import "/templates/exercise.typ": exercise, code, admonition

/* goals and lab-name are used by index.typ
   that's why we define and then pass them to the show rule */
#let lab-name = "RADIUS Authentication"
#let outcomes = ("build-managed", "enterprise")

#show: doc => exercise(
  course-name: "Wireless Network Security and Administration",
  exercise-name: lab-name,
  exercise-type: "Lab",
  outcomes: outcomes,
  doc,
)

== Background

In this lab you will setup 802.1X authentication as you would see via WPA2/WPA3 Enterprise Security with an access point and a RADIUS server running on your Mininet-WiFi VM. 

== Installing and Running FreeRADIUS

In a new terminal on your Mininet-WiFi VM, run `sudo apt update` followed by `sudo apt install freeradius` (the wifi user password is wifi).
Hit enter or 'y' when prompted to install the packages.

As root, edit the `/etc/freeradius/3.0/users` file and add the following lines to the top (you can do this via nano with `sudo nano /etc/freeradius/3.0/users` if you don't have a prefered Linux text editor):

#code([
  ```text
  user1 Cleartext-Password := "funfun"
  user2 Cleartext-Password := "sillywilly"
  ```
])

#admonition[
  #link("https://www.freeradius.org/documentation/freeradius-server/3.2.11/concepts/modules/ldap/authentication.html")[Typically a RADIUS server will connect to an LDAP server to get the password.]
  Here we're using plaintext passwords in FreeRADIUS so we do not have to install and configure additional tools.
]

Stop the background service that was started when you installed FreeRADIUS with `sudo systemctl stop freeradius`.
Now run FreeRADIUS in debug mode so we can see what happens when we connect, `sudo freeradius -X`.

If you did everything right, you should now have a terminal that looks like this:

#image("/images/radius-1.png")

== Bringing up the Mininet-WiFi Topology

Open a new terminal, but keep the FreeRADIUS terminal running in the background.

You should have #link("https://github.com/rxt1077/it620")[the class git repo] cloned from a previous lab.
Change into that directory and pull that latest updates: `cd it620; git pull` (if you have made changes you can use `git stash` to store them before you pull).

Now change into the `labs/radius` directory and bring up the Mininet-WiFi topology: `cd labs/radius; python3 radius.py`

You'll notice the FreeRADIUS terminal logging connection requests.
Use the FreeRADIUS output and the Mininet-WiFi CLI to answer the questions in the following section.

== Questions

+ There are three stations in this network, sta1, sta2, and sta3.
  From the Mininet-WiFi CLI you can use the following iw command to check the status of a WiFi link: `staN iw dev staN-wlan0 link`, where N is the station number (1, 2, or 3).
  Which stations are connected and which ones are not?
+ If any station is not connected, why isn't it connected? (Check the FreeRADIUS output)
+ Will a station that does not connect the first time try to reconnect?
+ What version of TLS is being used (to wrap EAP and make it PEAP) and what cipher suite is supported?

Now you can bring down the WPA2 network by typing `exit` in the Mininet-WiFi CLI and in the xterm.
You can stop FreeRADIUS with Ctrl-C in its terminal and then type exit in the xterm.
Finally you can shutdown the VM.
