#!/bin/bash
rm vpng* -R 2> /dev/null
today=`date +%d-%m-%y-%H-%M`
vpn_name="vpngate-$today" 
mkdir $vpn_name
cd $vpn_name
wget http://www.vpngate.net/api/iphone/ -O servlist.txt -q 
head -n -1 servlist.txt > temp.txt ; mv temp.txt servlist.txt
tail -n +3 servlist.txt > temp.txt ; mv temp.txt servlist.txt
i=0
while IFS="," read -r fn cfg
do 
   echo "$cfg" | base64 --decode>"$fn.ovpn" 2>/dev/null
   i=$((i + 1))
done < <(cut -d "," -f1,15 servlist.txt)
echo -e "vpn\nvpn">credentials.txt
echo -e "max_connections=999">vpn-provider-config.txt
rm servlist.txt
cd ..

