# to use tc to manipulate network latency
# On the node to slow traffic to the destination ip_1, ip_2, and ip_3
# run this on site 1. destination ips are for site 2

tc qdisc del dev eth0 root
sleep 1
tc qdisc add dev eth0 root handle 1: htb
sleep 1
# apply 60ms latency to node with ip ip_1
tc class add dev eth0 parent 1: classid 1:1 htb rate 1000mbit
sleep 1
tc filter add dev eth0 parent 1: protocol ip prio 1 u32 flowid 1:1 match ip dst 10.96.106.90/32
sleep 1
tc qdisc add dev eth0 parent 1:1 handle 10: netem delay 120ms
sleep 1

# apply 60ms latency to node with ip ip_2
tc class add dev eth0 parent 1: classid 1:2 htb rate 1000mbit
sleep 1
tc filter add dev eth0 parent 1: protocol ip prio 2 u32 flowid 1:2 match ip dst 10.96.106.89/32
sleep 1
tc qdisc add dev eth0 parent 1:2 handle 20: netem delay 120ms
sleep 1

# apply 60ms latency to node with ip ip_2
tc class add dev eth0 parent 1: classid 1:3 htb rate 1000mbit
sleep 1
tc filter add dev eth0 parent 1: protocol ip prio 3 u32 flowid 1:3 match ip dst 10.96.106.88/32
sleep 1
tc qdisc add dev eth0 parent 1:3 handle 30: netem delay 120ms
sleep 1

# apply latency to all the nodes you want to
# Re run the same commands on other nodes where you want latency to to be set
# If you want to set up latency between site 1 and site 2, run these commands on each of nodes of site 1, where those ip_1, ip_2 should be the ips of the nodes in site 2
