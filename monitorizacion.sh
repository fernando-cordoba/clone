#!/bin/bash
x=1;
for IP in $(cat datos.txt); do
IP=$IP;
echo ""
echo "-*-*-*-*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*--*"
ssh -t root@$IP bash -c "'
echo "Host:"
whoami
echo ""
echo "IP"
hostname -I
echo ""
echo "Info about memory:"
free
echo ""
echo "Info about disk:"
df -h
echo ""
echo "Logged users:"
who
echo ""
echo "Active process:"
ps aux
echo ""
echo "UDP Conections:"
ss -u
echo "TCP Conections:"
ss -t
echo ""
echo "route:"
ip route
if [[ $x == 1 ]]
then
echo ""
echo "DHCP Address:"
echo ""
echo "IP range address:"
cat /etc/dhcp/dhcp.conf | grep "range" | sed -n '1p'
echo ""
echo "Address assigned:"
echo ""
tail -n 20 /var/log/syslog | grep -E "DHCPACK"
elif [[ $x == 2 ]]
then
echo ""
echo "DNS Zones:"
cat /etc/bind/name.conf.local | grep "zone" | grep -v "/" | tr -d '{'
echo ""
echo "Translations:"
cat /etc/bind/db.zona1.org | tail -n 20 | grep "IN" | grep -v "interface"
cat /etc/bind/db.zona2.org | tail -n 20 | grep "IN" | grep -v "interface"
elif [[ $x == 3 ]]
then
echo ""
echo "Virtual hosts:"
apache2ctl -S | grep "namevhost"
fi
exit
'"
echo ""
x=`echo $((++x))`;
done

