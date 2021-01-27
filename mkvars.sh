#!/bin/sh
#
# make-vars: Makes a custom 'vars' file for use with the easyrsa commands

COUNTRY="US"
STATE="Minnesota"
CITY="Eagan"
ORG="EHS Robotics"
EMAIL="ca@eaganrobotics.com"
OU="Team 2220"

echo "The parameters you enter below will be used when forming the"
echo "component values of the client and server certificates."
echo "Choose values that correspond to your locality and team."
echo "(Default values are contained within brackets)"
echo ""

echo -n "Enter your country code [$COUNTRY]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    COUNTRY=$REPLY
fi

echo -n "Enter the name of your state or province [$STATE]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    STATE=$REPLY
fi

echo -n "Enter the name of your city [$CITY]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    CITY=$REPLY
fi

echo -n "Enter the name of your organization [$ORG]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    ORG=$REPLY
fi

echo -n "Enter your email address [$EMAIL]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    EMAIL=$REPLY
fi

echo -n "Enter the name of your organizational unit [$OU]: "
read REPLY
if [ "x$REPLY" != "x" ]; then
    OU=$REPLY
fi

VARSFILE=/etc/openvpn/easy-rsa/vars

sed -e "s/^#set_var \(EASYRSA_REQ_COUNTRY\).*/set_var\t\1\t\"$COUNTRY\"/" \
    -e "s/^#set_var \(EASYRSA_REQ_PROVINCE\).*/set_var\t\1\t\"$STATE\"/" \
    -e "s/^#set_var \(EASYRSA_REQ_CITY\).*/set_var\t\1\t\"$CITY\"/" \
    -e "s/^#set_var \(EASYRSA_REQ_ORG\).*/set_var\t\1\t\t\"$ORG\"/" \
    -e "s/^#set_var \(EASYRSA_REQ_EMAIL\).*/set_var\t\1\t\"$EMAIL\"/" \
    -e "s/^#set_var \(EASYRSA_REQ_OU\).*/set_var\t\1\t\t\"$OU\"/" \
	$VARSFILE.example > $VARSFILE
