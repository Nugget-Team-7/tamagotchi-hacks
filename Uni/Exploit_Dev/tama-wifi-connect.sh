#!/bin/bash
# For Tamagotchi Uni
# On Uni:
## Menu->Network (bottom right)->Network->Wi-Fi->(Select unused network slot (A button)->By Phone
#On Phone:
## Open Binary Eye app ( https://play.google.com/store/apps/details?id=de.markusfisch.android.binaryeye&hl=en_US&gl=US )
## Scan QR Code
## Copy string
## run this shell script ( ./tama-wifi-test.sh )
## Paste in full string
## run it
TAMA_SSID='TAMAGOTCHI_69F229'
wifi_interface=$1
echo 'Paste full string from Tamagotchi QR Code'
read FULLSTRING
PASS=`echo $FULLSTRING | awk -F: '{print substr($5,1, length($5)-2)}'`
echo "connecting to $TAMA_SSID with password $PASS"
sudo nmcli device wifi rescan
sudo nmcli device wifi connect 'TAMAGOTCHI_69F229' password $PASS ifname $wifi_interface
iwconfig
