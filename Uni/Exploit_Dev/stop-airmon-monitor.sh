INTERFACE_MON='wlan1mon'
INTERFACE_PHY='wlan1'
sudo airmon-ng stop $INTERFACE_MON
sudo systemctl start NetworkManager
sudo systemctl start wpa_supplicant
sudo ifconfig $INTERFACE_PHY up
sudo bash fix_wifi.sh $INTERFACE_PHY
