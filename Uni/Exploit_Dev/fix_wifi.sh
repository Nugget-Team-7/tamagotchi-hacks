wifi_device=$1

echo 'Starting NetworkManager.service'
sudo systemctl restart NetworkManager
echo 'Restarting wpa_supplicant'
sudo systemctl restart wpa_supplicant
echo 'Disconnecting from wifi'
sudo nmcli d disconnect $wifi_device
echo 'Deleting all wifi saved networks'
nmcli connection show | sudo awk '{system("nmcli connection delete " $1)}'
echo 'Bringing down interface'
sudo ifconfig $wifi_device down
echo 'Bringing back up interface'
sudo ifconfig $wifi_device up
echo 'Reloading network manager'
sudo nmcli g reload
echo 'Turning off network manager'
sudo nmcli n off
echo 'Turning on network manager'
sudo nmcli n on
echo 'Changing interface mode to managed'
sudo iwconfig $wifi_device mode managed
#iwconfig $wifi_device txpower off
#sleep 3
#iwconfig $wifi_device txpower auto
#echo 'Rfkilling wifi'
#sudo rfkill block wifi
#echo 'Rfkill unblocking wifi'
#sudo rfkill unblock wifi
#echo 'Restarting networking stack'
sudo systemctl restart networking
iwconfig
echo 'Done!'
