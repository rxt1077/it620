from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI
from mn_wifi.net import Mininet_wifi

setLogLevel('info')

net = Mininet_wifi()

info("Creating nodes...\n")
sta1 = net.addStation('sta1')
sta2 = net.addStation('sta2', passwd='Password@123', encrypt='wpa2')
sta3 = net.addStation('sta3', passwd='Password@123', encrypt='wpa2')
ap1  = net.addAccessPoint('ap1', ssid='wpa2net', mode='g', channel='1',
                            passwd='Password@123', encrypt='wpa2',
                            failMode='standalone', datapath='user')

info("Configuring WiFi nodes...\n")
net.configureWifiNodes()

info("Associating stations...\n")
net.addLink(sta2, ap1)
net.addLink(sta3, ap1)

info("Starting network...\n")
net.build()
ap1.start([])

info("Running CLI...\n")
CLI(net)

info("Stopping network...\n")
net.stop()
