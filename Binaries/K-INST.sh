#!/bin/bash
### PAUSE WAIT FOR ENTER
stop1 () {
    read -p "Press [Enter] to continue..."
    clear
}
echo "Unzipping Kernel Package"
tar -xf ~/Kernel-Install.tar.gz
rm -rf ~/Kernel-Install.tar.gz
echo ""
echo "Installing Modules"
cp -arfv ~/lib/modules/* /lib/modules/
echo "Modules Installed"
echo ""
echo "Copy DTB to /boot/test for testing"
cp -arfv ~/kirin970-hikey970.dtb /boot/test
echo "Copy KERNEL to /boot/test for testing"
cp -arfv ~/Image-hikey970-v4.9.gz /boot/test
echo "Kernel Installed for Testing Successful"
stop1
echo "Install Kernel to Primary System UFS"
echo ""
echo ""
read -n 1 -p "Install Kernel to Main System UFS YES - NO $nl $bb y/n $nl"
		if [[ $REPLY = "y" ]] || [[ $REPLY = "Y" ]]; then
			cp -arfv ~/kirin970-hikey970.dtb /boot/
			echo "DTB Installed"
			echo ""
			echo "Copy KERNEL to /boot/ "
			cp -arfv ~/Image-hikey970-v4.9.gz /boot/
			echo "Kernel Installed Successful"
		else
			echo ""
			echo "$yb $rt ONLY TEST KERNEL WAS INSTALLED $nl"	
		fi
exit 0