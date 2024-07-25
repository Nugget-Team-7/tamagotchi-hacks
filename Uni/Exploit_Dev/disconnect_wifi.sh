INTERFACE='wlan1'
echo 'Disconnecting from wifi...'
nmcli d disconnect $INTERFACE
sleep 3
echo 'Reloading network manager'
nmcli g reload
echo 'Done!'
