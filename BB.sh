#!/bin/bash
#################### CONSTANT VARIABLE DEFINITION #######################

### SET COLORS AND STYLES
rt=$(tput setaf 1)
rb=$(tput setb 4)
gt=$(tput setaf 2)
gb=$(tput setb 2)
yt=$(tput setaf 3)
yb=$(tput setb 6)
bt=$(tput setaf 4)
bb=$(tput setb 1)
bd=$(tput bold)
it=$(tput sitm)
nl=$(tput sgr0)

### SET PATH VARIABLES
cd
bb1=$(pwd)/Bionic-Builder
bb2=$bb1/Ubuntu-SRC
bb3=$bb2/rootfs
bb4=$bb3/boot
bb5=$bb3/etc
bb6=$bb3/lib
bb7=$bb3/root
bb8=$bb4/EFI
bb9=$bb4/grub
bb10=$bb8/BOOT
bb11=$bb5/netplan
bb12=$bb5/update-motd.d
bb13=$bb6/firmware
bb14=$bb6/modules
bb15=$bb13/ti-connectivity
bf=$bb1/Binaries
kconf=$bb1/Kernel-Configs
### SET Mirror for ubuntu src https://launchpad.net/ubuntu/+archivemirrors
SRC=http://mirror.enzu.com/ubuntu/
#################### FUNCTION DEFINITIONS #######################

SRCES () {
echo "wget -q https://dl.google.com/linux/linux_signing_key.pub -O- | sudo apt-key add -" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1378B444" | sudo tee -a $bb7/init.sh
echo "sudo wget -O - http://apt.mucommander.com/apt.key | sudo apt-key add -" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  247510BE" | sudo tee -a $bb7/init.sh
echo "sudo wget -O - http://deb.opera.com/archive.key | sudo apt-key add -" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC93F7A" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1378B444" | sudo tee -a $bb7/init.sh
echo "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  247510BE" | sudo tee -a $bb7/init.sh
}

### PAUSE WAIT FOR ENTER
CMP () {
	echo "$gb $bd $yt Operation Complete $nl"
    read -p "Press [Enter] to continue..."
    clear
}

### PAUSE WAIT FOR ENTER
stop1 () {
    read -p "Press [Enter] to continue..."
    clear
}

INIBAN () {
echo $gt
echo "'	 ___       _ _         ____                      _      _		 '"
echo "'	|_ _|_ __ (_) |_      / ___|___  _ __ ___  _ __ | | ___| |_ ___	  "
echo "'	 | ||  _ \| | __|____| |   / _ \|  _   _ \|  _ \| |/ _ \ __/ _ \ '"
echo "'	 | || | | | | ||_____| |__| (_) | | | | | | |_) | |  __/ ||  __/ '"
echo " 	|___|_| |_|_|\__|     \____\___/|_| |_| |_| .__/|_|\___|\__\___|  "
echo "                                            |_|					  "
echo ""
echo "		    $bb INITIAL ROOTFS SETUP IS COMPLETE $nl"
echo "$gt $bd 	RUN OPTION 2 TO DOWNLOAD REMAINING ROOTFS PACKAGES $nl"
echo ""
stop1
}

USEBAN () {
echo $yt
echo "	      _            _           ____             __ _"
echo "	     / \   ___ ___| |_        / ___|___  _ __  / _(_) __ _"
echo "	    / _ \ / __/ __| __| _____| |   / _ \| '_ \| |_| |/ _  |"
echo "	   / ___ \ (_| (__| |_ |_____| |__| (_) | | | |  _| | (_| |"
echo "	  /_/   \_\___\___|\__(_)     \____\___/|_| |_|_| |_|\__, |"
echo " 							      |___/"
echo ""
echo "		$bb CREATING USER AND PASSWORD FOR UBUNTU LOGIN $nl"
echo "	  $rt $bd    THE USERNAME MUST BE LOWERCASE WITHOUT SPACES $nl"
echo ""
}

MIRBAN () {
echo $yt
echo " 	  ____ _                            __  __ _"
echo " 	 / ___| |__   ___   ___  ___  ___  |  \/  (_)_ __ _ __ ___  _ _	"
echo "	| |   | '_ \ / _ \ / _ \/ __|/ _ \ | |\/| | | '__| '__/ _ \| '__|"
echo "	| |___| | | | (_) | (_) \__ \  __/ | |  | | | |  | | | (_) | |"	 
echo "	 \____|_| |_|\___/ \___/|___/\___| |_|  |_|_|_|  |_|  \___/|_|"
echo "$nl"
echo "	$bb YOU CAN USE ANY MIRRIOR FOR DOWNLOADING THE SRC PACKAGES  $nl"
echo "	$yt Go To https://launchpad.net/ubuntu/+archivemirrors      $nl"
echo "	$gt SELECT THE FASTEST MIRROR FOR YOUR COUNTRY AND LOCATION  $nl"
echo ""
echo "$bb$yt Press enter to use DEFAULT"
echo "$bb$yt Or Paste Your Mirror Address Then Press ENTER$nl"
}


BIOBAN () {
echo "$bb$bt**********************************************************************************$nl"
echo "$rt$bd**********************************************************************************$yt"
echo " 	   ____  _             _           ____        _ _     _					 "
echo "	  | __ )(_) ___  _ __ (_) ___     | __ ) _   _(_) | __| | ___ _ __			 "
echo "	  |  _ \| |/ _ \|  _ \| |/ __|____|  _ \| | | | | |/ _  |/ _ \  __|		 "
echo "	  | |_) | | (_) | | | | | (_|_____| |_) | |_| | | | (_| |  __/ |			 "
echo "	  |____/|_|\___/|_| |_|_|\___|    |____/ \__ _|_|_|\__ _|\___|_|			 "
echo ""
echo "$rt$bd**********************************************************************************$nl"
echo "$bb$bt**********************************************************************************$nl"
echo "$nl"
}

MKUSR () {
	USEBAN
	usenm=""
	pword=""
	echo "$bb Enter The Username You Want to Use $nl"
	echo ""
	read -e usenm1
	usenm=$(echo "$usenm1" | sed 's/ /_/g')
	echo "$bb Enter The Password For this User $nl"
	echo ""	
	read -e pword1
	pword=$(echo "$pword1" | sed 's/ /_/g')
	echo "$yt USERNAME =$gt $usenm"
	echo "$yt PASSWORD = $gt $pword"
	read -n 1 -p "ARE Username & Password Correct? $nl $bb y/n $nl"
		if [[ $REPLY = "y" ]] || [[ $REPLY = "Y" ]]; then
			clear
			echo ""
			echo "$gt You will Login to your Hikey970 With theese $nl"
			echo "$yt USERNAME =$gt $usenm $nl"
			echo "$yt PASSWORD = $gt $pword $nl"
			stop1
		else
			echo ""
			echo "$yb $rt TRY AGAIN $nl"
			MKUSR
		fi
}

NETCFG () {
	ap=""
	pw=""
	echo "$yb $bt CONFIGURING NETWORK $nl"
	echo ""
	echo "$yt LAN Connection is DCHP Default and works without modification"
	echo "$yt WIFI Connection is DCHP Default and Requires Accesspoint Name and Password"
	echo "$bt $gb     SETTING WIFI AP NAME AND PASSWORD $rt!! NO SPACES CAN BE USED !! $nl"
	echo ""
	echo "$bb Enter Access Point Name $nl"
	read -e apname1
	ap=$(echo "$apname1" | sed 's/ /_/g')
	ap3=":"
	ap=$ap$ap3
	echo "$gt Access Point = $ap $nl"
	echo "$bb Enter Password $nl"
	read -e apname2
	pw=$(echo "$apname2" | sed 's/ /_/g')
	echo "$gt Password is = $pw $nl"
	REPLY=""
	read -n 1 -p "Are the AP Name and Password Correct? $nl $bb y/n $nl"
	if [[ $REPLY = "y" ]] || [[ $REPLY = "Y" ]]; then
		echo "$gt WIFI is Configured $nl"
	else
		echo "$rt $yb TRY AGAIN $nl"
		NETCFG
	fi
}

SETMR () {
	MIRBAN
		mirror=""
		read -e mirror1
		mirror=$(echo "$mirror1" | sed 's/ /_/g')
		 if [[ $mirror = "" ]]; then
			echo "$bb Using Default $SRC $nl"
			stop1
		 else
			SRC=$mirror
			echo "$bb Using Entered Mirror $SRC $nl"
			stop1
		fi
}

MAMN () {
echo "$yt $it $bd (1) CREATE MINIMAL BASE ROOT FILESYSTEM $nl"
echo ""
echo "$yt $it $bd (2) CHROOT AND DOWNLOAD BIONIC PACKAGES $nl"
echo ""
echo "$yt $it $bd (3) BUILD KERNEL LINUX v4.9.78 $nl"
echo ""
echo "$yt $it $bd (4) CHROOT AND INSTALL KERNEL MODULES in ROOTFS $nl"
echo ""
echo "$yt $it $bd (5) GENERATE FLASHABLE AND COMPRESSED IMAGES $nl"
echo ""
echo "$yt $it $bd (6) FASTBOOT FLASH UBUNTU BIONIC 18.04 $nl"
echo ""
echo "$yt $rb $it $bd (99) EXIT BUILDER $nl"
echo ""
}

FRDS () {
    if [ -d $bb2 ] && [ -d $bb3 ] && [ -d $bb4 ] && [ -d $bb5 ] && [ -d $bb6 ]; then
        echo "$rb $yt Rootfs Found / Previous Build Exsist $nl"
		echo "$rt $yb"
			REPLY=""
			read -n 1 -p "Press r to Rename / d to delete / x to exit $nl $bb r/d/x $nl"
			if [[ $REPLY = "d" ]] || [[ $REPLY = "D" ]]; then
				rm -rf $bb2
				echo "$nl"
				echo "$rb $yt Previous Build Removed $nl"
				echo "$gb $bt Re-Create Directory Structure $nl"
				MRTFS
				CPFS
				CMP
			elif [[ $REPLY = "r" ]] ||[[ $REPLY = "R" ]]; then
				echo "$yt Rename Previous Build $nl"
				echo "$bb Enter Name for Backup $nl"
				read -e backup1
				backup=$(echo "$backup1" | sed 's/ /_/g')
				mv $bb2 $bb1/$backup
				echo "$bb Previous Build Renamed to $backup $nl"
				MRTFS
				CPFS
				CMP
			elif [[ $REPLY = "x" ]] ||[[ $REPLY = "X" ]]; then
				echo "$yt User Choose Exit $nl"
				echo "$rt $yb Returning to Main Menu $nl"
				SMM	
			else 
				echo "$rt You Pressed a Invalid Key $nl"
				FRDS
			fi
    else
        echo "$yt Creating Rootfs Directory Structure $nl"
		MRTFS
		CPFS
		CMP
    fi
}

MRTFS () {
	CRE="${yt} -->> Created ${gt}"
	echo ""
	echo "$bb Creating Base Root Filesystem $nl"
	echo "$gt"
	mkdir $bb2
		echo "$bb2" $CRE
	mkdir $bb3
		echo "$bb3" $CRE
	mkdir $bb4
		echo "$bb4" $CRE
	mkdir $bb5
		echo "$bb5" $CRE
	mkdir $bb6
		echo "$bb6" $CRE
	mkdir $bb7
		echo "$bb7" $CRE
	mkdir $bb8
		echo "$bb8" $CRE
	mkdir $bb9
		echo "$bb9" $CRE
	mkdir $bb10
		echo "$bb10" $CRE
	mkdir $bb11
		echo "$bb11" $CRE
	mkdir $bb12
		echo "$bb12" $CRE
	mkdir $bb13
		echo "$bb13" $CRE
	mkdir $bb14
		echo "$bb14" $CRE
	mkdir $bb15
		echo "$bb15" $CRE
	echo ""
	echo "$bb Directory Structure Creation Complete $nl"
}

CPFS () {
	CRE="${yt} -->> COPIED ${gt}"
	echo ""
	echo "$bb Move Binaries to Base Root Filesystem $nl"
	echo "$gt"
	cp -a $bf/fastboot.efi $bb10/
		echo "$bb10/fastboot.efi" $CRE
	cp -a $bf/grub.cfg $bb9/
		echo "$bb9/grub.cfg" $CRE
	cp -a $bf/initramfs-v4.9 $bb4/
		echo "$bb4/initramfs-v4.9" $CRE
	cp -a $bf/Image-hikey970-v4.9.gz $bb4/
		echo "$bb4/Image-hikey970-v4.9.gz" $CRE
	cp -a $bf/kirin970-hikey970.dtb $bb4/
		echo "$bb4/kirin970-hikey970.dtb" $CRE		
	cp -a $bf/wl18xx-conf.bin $bb15/
		echo "$bb15/wl18xx-conf.bin" $CRE	
	cp -a $bf/sources.list $bb7/
		echo "$bb7/sources.list" $CRE	
	cp -a $bf/README.md $bb2/
		echo "$bb2/README.md" $CRE	
	cp -a $bf/LICENSE $bb2/
		echo "$bb2/LICENSE" $CRE			
	cp -a $bf/11-image-support $bb12/
		echo "$bb12/11-image-support" $CRE
	clear
	echo "$bb Configure Base Root Filesystem $nl"
	echo ""
	echo "$gt Create Username and Password $nl"
	MKUSR
	touch $bb7/init.sh
	echo "#!/bin/bash" | sudo tee -a $bb7/init.sh
	echo "set -ue" | sudo tee -a $bb7/init.sh
	echo "useradd -g sudo -m -s /bin/zsh $usenm" | sudo tee -a $bb7/init.sh
	echo "echo $usenm:$pword | chpasswd" | sudo tee -a $bb7/init.sh
	qts='"'
	hk="hikey970"
	adr="127.0.0.1 hikey970"
	echo "echo $qts#made by $usenm$qts >> /home/$usenm/.zshrc" | sudo tee -a $bb7/init.sh
	echo "passwd -d root" | sudo tee -a $bb7/init.sh
	echo "rm -rf /debootstrap" | sudo tee -a $bb7/init.sh
	echo "apt clean && apt autoclean" | sudo tee -a $bb7/init.sh
	echo "rm -f /etc/ssh/ssh_host_*" | sudo tee -a $bb7/init.sh
	echo "echo $qts$hk$qts > /etc/hostname" | sudo tee -a $bb7/init.sh
	echo "echo $qts$adr$qts >> /etc/hosts" | sudo tee -a $bb7/init.sh
	echo "cp -a /root/sources.list etc/apt/" | sudo tee -a $bb7/init.sh
	echo "rm -rf etc/apt/sources.list" | sudo tee -a $bb7/init.sh
	SRCES
	echo "apt-get update && apt-get upgrade" | sudo tee -a $bb7/init.sh
	echo "rm /root/init.sh" | sudo tee -a $bb7/init.sh
	chmod 0755 $bb7/init.sh
	echo "$bb7/init.sh" $CRE
	clear
	echo ""
	echo "$gt Set Download Mirror For Bionic SRC $nl"
	SETMR
	touch $bb5/rc.local
	echo "#!/bin/bash" | sudo tee -a $bb5/rc.local
	echo "# re-generate ssh host key" | sudo tee -a $bb5/rc.local
	echo "test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server" | sudo tee -a $bb5/rc.local		
	chmod 775 $bb5/rc.local
	echo "$bb5/rc.local" $CRE
	clear
	echo ""
	echo "$gt Configure Network $nl"
	NETCFG
	touch $bb11/01-dhcp.yaml
	echo "network:" | sudo tee -a $bb11/01-dhcp.yaml
	echo " version: 2" | sudo tee -a $bb11/01-dhcp.yaml
	echo " renderer: NetworkManager" | sudo tee -a $bb11/01-dhcp.yaml
	echo " ethernets:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "     enp6s0:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "        dhcp4: true" | sudo tee -a $bb11/01-dhcp.yaml
	echo "        dhcp6: true" | sudo tee -a $bb11/01-dhcp.yaml
	echo "network:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "    version: 2" | sudo tee -a $bb11/01-dhcp.yaml
	echo "    wifis:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "        wlan0:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "             renderer: NetworkManager" | sudo tee -a $bb11/01-dhcp.yaml
	echo "             dhcp4: true" | sudo tee -a $bb11/01-dhcp.yaml
	echo "             dhcp6: true" | sudo tee -a $bb11/01-dhcp.yaml
	echo "             access-points:" | sudo tee -a $bb11/01-dhcp.yaml
	echo "                 $ap" | sudo tee -a $bb11/01-dhcp.yaml
	echo "                     password: $pw" | sudo tee -a $bb11/01-dhcp.yaml		
	echo "$bb11/01-dhcp.yaml" $CRE
	echo "$bb File Creation Complete $nl"
	clear
	INIBAN
}


##################################### MAIN MENU #####################################
SMM () {
    clear               
	BIOBAN
	MAMN
    #pinfo       
    echo "${bd}${bb}${yt} MAKE CHOICE AND PRESS ENTER. $nl"

    while [ 1 ]
    do
        read CHOICE
        case "$CHOICE" in

            "1") ### Build Base Filesystem
                echo "$bb Checking For Previous Build $nl"
				echo ""
				FRDS
                SMM
                ;;

            "2") ### 
                clear
                ShowFilesMenu
                ;;
            
            "3") ###

                resize -s 30 80
                clear
                ShowKeysMenu
                ;;
            
            "4") ### 
                clear
                ShowRecoveryMenu
                ;;
            
            "5") ###
                clear
                ShowFlashMenu
                ;;

            "6") ###
                clear
                ShowSignMenu
                ;;

            "7") ###
                clear
                ShowProjectMenu
                ;;
            "99")
				clear
                exit 0
                ;;
        esac
    done
}

#################### MAIN PROGRAM / SCRIPT #######################
### Set Exit on any Error
set -ue -o pipefail
### Notify Start of Script
resize -s 30 82
clear
echo "$bb Starting Build Script Ubuntu Bionic 18.04 Server $nl"
echo ""
echo "$yt Bionic-Builder is a All in 1 Compiler Script For Hikey970 $nl"
echo "$yt View Readme or visit https://github.com/Bigcountry907/Bionic-Builder $nl"
echo "$yt Created by BigCountry907 @ https://discuss.96boards.org/c/products/hikey970 $nl"
echo ""
c=5
REWRITE="\e[25D\e[1A\e[K"
echo "Starting..."
while [ $c -gt 0 ]; do 
    c=$((c-1))
    sleep 1
    echo -e "${REWRITE}$c"
done
echo -e "${REWRITE}Done."
### Call The Main Menu
SMM
exit 0
