#!/bin/sh

# Define Bridge Interface
br="br0"

# Define list of TAP interfaces to be bridged,
# for example tap="tap0 tap1 tap2".
tap="tap0"

# Define physical ethernet interface to be bridged
# with TAP interface(s) above.
eth="eth0"
eth_ip_netmask="10.TE.AM.251/24"
eth_broadcast="10.TE.AM.255"
eth_gateway="10.TE.AM.1"

case "$1" in
start)
    for t in $tap; do
        openvpn --mktun --dev $t
    done

    brctl addbr $br
    brctl addif $br $eth

    for t in $tap; do
        brctl addif $br $t
    done

    for t in $tap; do
        ip addr flush dev $t
        ip link set $t promisc on up
    done

    ip addr flush dev $eth
    ip link set $eth promisc on up

    ip addr add $eth_ip_netmask broadcast $eth_broadcast dev $br
    ip link set $br up

#   ip route add default via $eth_gateway
    ;;
stop)
    ip link set $br down
    brctl delbr $br

    for t in $tap; do
        openvpn --rmtun --dev $t
    done

    ip link set $eth promisc off up
    ip addr add $eth_ip_netmask broadcast $eth_broadcast dev $eth

#   ip route add default via $eth_gateway
    ;;
*)
    echo "Usage:  openvpn-bridge {start|stop}"
    exit 1
    ;;
esac
exit 0
