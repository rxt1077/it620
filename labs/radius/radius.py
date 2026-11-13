from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI
from mn_wifi.net import Mininet_wifi


setLogLevel('info')

net = Mininet_wifi()

info("Creating nodes...\n")
sta1 = net.addStation('sta1', encrypt='wpa2', radius_identity='user1', radius_passwd='funfun')
sta2 = net.addStation('sta2', encrypt='wpa2', radius_identity='user2', radius_passwd='sillywilly')
sta3 = net.addStation('sta3', encrypt='wpa2', radius_identity='user3', radius_passwd='invalid')

ap1 = net.addAccessPoint('ap1', encrypt='wpa2', ssid='ssid-radius',
                         authmode='8021x', datapath='user',
                         shared_secret='testing123')

info("Configuring wifi nodes...\n")
net.configureWifiNodes()

info("Associating stations...\n")
net.addLink(sta1, ap1)
net.addLink(sta2, ap1)
net.addLink(sta3, ap1)

info("Starting network...\n")
net.build()
ap1.start([])

info("Running CLI...\n")
CLI(net)

info("Stopping network...\n")
net.stop()
