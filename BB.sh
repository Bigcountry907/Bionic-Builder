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

#################### PATH DEFINITION #######################

cd
###Main Directory
bb1=$(pwd)/Bionic-Builder
###SRC stage Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/
bbb2=$bb1/Ubuntu-SRC
###SRC BUILD Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build
bb2=$bb1/Ubuntu-SRC/build
### Rootfs Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs
bb3=$bb2/rootfs
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/boot
bb4=$bb3/boot
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/etc
bb5=$bb3/etc
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/lib
bb6=$bb3/lib
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/root
bb7=$bb3/root
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/boot/EFI
bb8=$bb4/EFI
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/boot/grub
bb9=$bb4/grub
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/boot/EFI/BOOT
bb10=$bb8/BOOT
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/etc/netplan
bb11=$bb5/netplan
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/etc/update-motd.d
bb12=$bb5/update-motd.d
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/lib/firmware
bb13=$bb6/firmware
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/lib/modules
bb14=$bb6/modules
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/lib/firmware/ti-connectivity
bb15=$bb13/ti-connectivity
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/usr
bb17=$bb3/usr
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/usr/share
bb18=$bb17/share
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/usr/share
bb19=$bb18/keyrings
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/usr/lib
bb20=$bb17/lib
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/usr/lib/aarch64-linux-gnu
bb21=$bb20/aarch64-linux-gnu
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/lib/firmware/edid
bb22=$bb13/edid
### Directory $(pwd)/Bionic-Builder/Ubuntu-SRC/build/rootfs/etc/apt
bb23=$bb5/apt/
###SRC BINARIES Directory $(pwd)/Bionic-Builder/Binaries
bf=$bb1/Binaries
###KERNEL SRC FILES ROOT
ksrc=$bb1/Kernel-SRC
###KERNEL SRC FILES
ksrc1=$ksrc/linux
###KERNEL CONFIG FILES $(pwd)/Bionic-Builder/Binaries
kconf=$bb1/Kernel-Configs
tc=$bb1/Tool-Chain
###Kernel Image
kimg=$ksrc1/arch/arm64/boot/Image.gz
### Device Tree
devtre=$ksrc1/arch/arm64/boot/dts/hisilicon/kirin970-hikey970.dtb
### Needed Packages to build image
REQUIRED="qemu-debootstrap img2simg mkfs.ext4"

#################### FUNCTION DEFINITIONS #######################

### MESSAGE THAT DIRECTORY OF FILE WAS CREATED
CRE="${yt} -->> Created ${gt}"

SETTC () {
TCBAN
		mkdir $tc
		chmod 777 $tc
		cd $tc
		wget https://developer.arm.com/-/media/Files/downloads/gnu-a/8.2-2019.01/gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu.tar.xz
		tar -xf gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu.tar.xz
		rm -rf gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu.tar.xz
		mv gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu gcc-arm-8.2
		cd $bb1
CMP
}

BLDKER () {
		thread=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
		thduse=$(($thread - 2))
		KERBAN
		echo ""
		read -n 1 -p "$gb $bt ENTER CHOICE $nl $bb B/C/O/X $nl"
		if [[ $REPLY = "b" ]] || [[ $REPLY = "B" ]]; then
			echo "$nl"
			clear
			cd $tc
			export PATH=$(pwd)/gcc-arm-8.2/bin/:$PATH
			export CROSS_COMPILE=$(pwd)/gcc-arm-8.2/bin/aarch64-linux-gnu-
			aarch64-linux-gnu-gcc --version
			cd $ksrc1
			export ARCH=arm64
			make ARCH=arm64 mrproper
			make ARCH=arm64 hikey970_defconfig
			make ARCH=arm64 -j20
			CMP
		elif [[ $REPLY = "c" ]] || [[ $REPLY = "C" ]]; then
			echo "$nl"
			clear
			cd $tc
			export PATH=$(pwd)/gcc-arm-8.2/bin/:$PATH
			export CROSS_COMPILE=$(pwd)/gcc-arm-8.2/bin/aarch64-linux-gnu-
			aarch64-linux-gnu-gcc --version
			cd $ksrc1
			export ARCH=arm64
			make ARCH=arm64 hikey970_defconfig
			make menuconfig
			make ARCH=arm64 -j20
			CMP
		elif [[ $REPLY = "o" ]] || [[ $REPLY = "O" ]]; then
			clear
			echo "$nl"
			cd $tc
			export PATH=$(pwd)/gcc-arm-8.2/bin/:$PATH
			export CROSS_COMPILE=$(pwd)/gcc-arm-8.2/bin/aarch64-linux-gnu-
			aarch64-linux-gnu-gcc --version
			cd $ksrc1
			export ARCH=arm64
			make ARCH=arm64 oldconfig
			make ARCH=arm64 -j20
			CMP
		elif [[ $REPLY = "x" ]] || [[ $REPLY = "X" ]]; then	
			echo "$nl"
			SMM
		else
			echo "$nl"
			echo "$yb $rt YOU PRESSED THE WRONG KEY $nl"
			echo "$yb $rt PLEASE MAKE SELECTION FROM LIST $nl"
			BLDKER
		fi

}

DLKER () {
echo "$gb $yt $bd DOWNLOADING KERNEL SOURCE $nl"
stop1
mkdir $ksrc
chmod 755 $ksrc
cd $ksrc
git clone https://github.com/Bigcountry907/linux.git -b hikey970-v4.9-Debain-Working
chmod 755 $ksrc/linux
CMP
}

### MESSAGE THAT OPERATION IS COMPLETE
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
### SET Mirror for ubuntu src https://launchpad.net/ubuntu/+archivemirrors
	MIRBAN
		echo "$bb $yt $bd CHOOSE A MIRROR TO DOWNLOAD FROM $nl"
		echo "$bb Type the Letter to Choose or Type F to enter a custom Mirror $nl"
		echo ""
		echo "$rt A) $gt http://ftp.tu-chemnitz.de/pub/linux/ubuntu-ports/ $nl"
		echo "$yt SPEED = 1 Gbps / Country = Germany $nl"
		echo ""
		echo "$rt b) $gt http://dafi.inf.um.es/ubuntu/ $nl"
		echo "$yt SPEED = 100 Mbs / Country = Spain $nl"
		echo ""
		echo "$rt c) $gt http://mirrors.ustc.edu.cn/ubuntu-ports $nl"
		echo "$yt SPEED = ??? / Country = China $nl"
		echo ""
		echo "$rt E) $rt ENTER CUSTOM MIRROR ADDRESS $nl"
		echo ""		
		mirror=""
		read -n 1 -p "CHOOSE A B C, or D to type your own $nl $bb a/b/c/d/ $nl"
			if [[ $REPLY = "A" ]] || [[ $REPLY = "a" ]]; then
				mirror=http://ftp.tu-chemnitz.de/pub/linux/ubuntu-ports/
				echo ""
				echo "$yt SPEED = 1 Gbps / Country = Germany $nl"
				echo "$bb Selected ->> $mirror $nl"
				echo ""
				stop1
			elif [[ $REPLY = "b" ]] || [[ $REPLY = "B" ]]; then
				mirror=http://dafi.inf.um.es/ubuntu/
				echo ""
				echo "$yt SPEED = 10 Gbps / Country = Norway $nl"
				echo "$bb Selected ->> $mirror $nl"
				echo ""
				stop1
			elif [[ $REPLY = "c" ]] || [[ $REPLY = "C" ]]; then
				mirror=http://mirrors.ustc.edu.cn/ubuntu-ports
				echo ""
				echo "$yt SPEED = 100 Mbs / Country = Spain $nl"
				echo "$bb Selected ->> $mirror $nl"
				echo ""
				stop1
			elif [[ $REPLY = "d" ]] || [[ $REPLY = "D" ]]; then
					echo "$yt CUSTOM MIRROR $nl"
				mirror=
					echo "$gb $rt ENTER MIRROR TO USE $nl"
					read -e usenm5
					mirror=$(echo "$usenm5" | sed 's/ /_/g')
					echo ""
					echo "$bb Enter The Mirror address $nl"
					echo ""
					echo "$bb Selected ->> $mirror $nl"
					echo ""	
					stop1
			else
				echo "$rt YOU HIT A BAD KEY TRY AGAIN $nl"
				SETMR
			fi
}

MAMN () {
echo "$yt $it $bd (1) CREATE MINIMAL BASE ROOT FILESYSTEM $nl"
echo ""
echo "$yt $it $bd (2) BUILD KERNEL LINUX v4.9.78 $nl"
echo ""
echo "$yt $it $bd (3) COPY KERNEL & DEVICE TREE / INSTALL KERNEL MODULES in ROOTFS $nl"
echo ""
echo "$yt $it $bd (4) GENERATE FLASHABLE AND COMPRESSED IMAGES $nl"
echo ""
echo "$yt $it $bd (5) FASTBOOT FLASH UBUNTU BIONIC 18.04 to Hikey970 $nl"
echo ""
echo ""
echo "$yt $rb $it $bd (99) EXIT BUILDER $nl"
echo ""
}

FRDS () {
	echo "FINDING EXSISTING BUILDS"
    if [ -d $bb2 ] && [ -d $bb3 ] && [ -d $bb4 ] && [ -d $bb5 ] && [ -d $bb6 ]; then
        echo "$rb $yt Rootfs Found / Previous Build Exsist $nl"
		echo "$rt $yb"
			REPLY=""
			read -n 1 -p "Press r to Rename / d to delete / x to exit $nl $bb r/d/x $nl"
			if [[ $REPLY = "d" ]] || [[ $REPLY = "D" ]]; then
				rm -rf $bbb2
				echo "$nl"
				echo "$rb $yt Previous Build Removed $nl"
				echo "$gb $bt Re-Create Directory Structure $nl"
			elif [[ $REPLY = "r" ]] ||[[ $REPLY = "R" ]]; then
				echo "$yt Rename Previous Build $nl"
				echo "$bb Enter Name for Backup $nl"
				read -e backup1
				backup=$(echo "$backup1" | sed 's/ /_/g')
				mv $bb2 $bb1/$backup
				echo "$bb Previous Build Renamed to $backup $nl"
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
    fi
}

MRTFS () {
	if [ -d $bbb2 ]; then
	chmod 777 $bbb2
	echo "Ubuntu-SRC Found"
	else
	mkdir $bbb2
	chmod 777 $bbb2
	fi
	mkdir $bb2
	chmod 777 $bb2
	mkdir $bb3
	chmod 755 $bb3
	mkdir $bb4
	chmod 755 $bb4
	mkdir $bb5
	chmod 755 $bb5
	mkdir $bb6
	chmod 755 $bb6
	mkdir $bb7
	chmod 700 $bb7
	mkdir $bb8
	chmod 755 $bb8
	mkdir $bb9
	chmod 755 $bb9
	mkdir $bb10
	chmod 755 $bb10
	mkdir $bb11
	chmod 755 $bb11
	mkdir $bb12
	chmod 755 $bb12
	mkdir $bb13
	chmod 755 $bb13
	mkdir $bb14
	chmod 755 $bb14
	mkdir $bb15	
	chmod 755 $bb15
	mkdir $bb17	
	chmod 755 $bb17
	mkdir $bb18
	chmod 755 $bb18
	mkdir $bb19
	chmod 755 $bb19
	mkdir $bb20
	chmod 755 $bb20
	mkdir $bb21
	chmod 755 $bb21
	mkdir $bb22
	chmod 755 $bb22
}

CPFS () {
	cp -a $bf/fastboot.efi $bb10/
	cp -a $bf/grub.cfg $bb9/
	cp -a $bf/1920x1080.bin $bb22/
	chmod 755 $bb22/1920x1080.bin
	chmod 444 $bb9/grub.cfg
	cp -a $bf/initramfs-v4.9 $bb4/
	chmod 644 $bb4/initramfs-v4.9
	#cp -a $bf/Image-hikey970-v4.9.gz $bb4/
	#chmod 600 $bb4/Image-hikey970-v4.9.gz
	#cp -a $bf/kirin970-hikey970.dtb $bb4/
	#chmod 644 $bb4/kirin970-hikey970.dtb
	cp -a $bf/wl18xx-conf.bin $bb15/
	chown 0.0 $bb15/wl18xx-conf.bin
	chmod 755 $bb15/wl18xx-conf.bin
	cp -a $bf/LICENSE $bb2/		
	cp -a $bf/11-image-support $bb12/
	cp -a $bf/libmali.so $bb21/	
	cp -a $bf/keyrings/* $bb19/
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
	echo "rm /root/init.sh" | sudo tee -a $bb7/init.sh
	chmod 0755 $bb7/init.sh
	echo "$bb7/init.sh" $CRE
	touch $bb7/locale.sh
	echo "#!/bin/bash" | sudo tee -a $bb7/locale.sh
	echo "set -ue" | sudo tee -a $bb7/locale.sh
	echo "locale-gen en_US.UTF-8" | sudo tee -a $bb7/locale.sh
	echo "update-locale LANG=en_US.UTF-8" | sudo tee -a $bb7/locale.sh
	echo "rm /root/locale.sh" | sudo tee -a $bb7/locale.sh
	chmod 0755 $bb7/locale.sh
	echo "$bb7/locale.sh" $CRE
	SETMR
	touch $bb5/rc.local
	echo "#!/bin/bash" | sudo tee -a $bb5/rc.local
	echo "# re-generate ssh host key" | sudo tee -a $bb5/rc.local
	echo "test -f /etc/ssh/ssh_host_rsa_key || dpkg-reconfigure openssh-server" | sudo tee -a $bb5/rc.local		
	chmod 775 $bb5/rc.local
	echo "$bb5/rc.local" $CRE
	clear
	NETCFG
	touch $bb11/01-dhcp.yaml
	chmod 755 $bb11/01-dhcp.yaml
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
}

MKIMG () {
DISTRO=${DISTRO:-"bionic"}
VERSION=V-1.0
SYSTEM_SIZE=${SYSTEM_SIZE:-'2048'} # 1G
echo "Building image" $SYSTEM_SIZE
dd if=/dev/zero of=$bb2/rootfs.img bs=1M count=$SYSTEM_SIZE conv=sparse
mkfs.ext4 -L rootfs $bb2/rootfs.img

if [[ ! -d $bb2/loop ]]; then
	mkdir $bb2/loop
	mount -t ext4 -o loop $bb2/rootfs.img $bb2/loop
else
	echo "Loop Exsist"
	mount -t ext4 -o loop $bb2/rootfs.img $bb2/loop
fi

echo "Copying root"
cp -arv $bb3/* $bb2/loop/
echo "Umount"
umount $bb2/loop

echo "Building sparse"
export SPARSE_IMG="ubuntu_$DISTRO.hikey970.$VERSION.sparse.img"
img2simg $bb2/rootfs.img $bb2/$SPARSE_IMG

echo "Cleaning Up"
rm -rf $bb2/rootfs.img

#echo "Compressing"
# tar -C build -czvf $bb2/$SPARSE_IMG.tar.gz $bb2/$SPARSE_IMG

echo "ALL COMPLETE"
ls -lha $bb2/$SPARSE_IMG
sha1sum $bb2/$SPARSE_IMG
CMP
}

INSKER () {
echo "$gb $bt COPY KERNEL $nl"
if [[ ! -f $bb4/Image-hikey970-v4.9.gz ]]; then
	cp -avrf $kimg $bb4/  
	mv $bb4/Image.gz $bb4/Image-hikey970-v4.9.gz
	echo "$gb $bt Image Copied $nl"
else
	rm -rf $bb4/Image-hikey970-v4.9.gz
	cp -avrf $kimg $bb4/  
	mv $bb4/Image.gz $bb4/Image-hikey970-v4.9.gz
	echo "$gb $bt Image Copied $nl"
fi
echo "$gb $bt COPY DEVICE TREE $nl"
if [[ ! -f $bb4/kirin970-hikey970.dtb ]]; then
	cp -avrf $devtre $bb4/
	echo "$gb $bt DEVICE TREE Copied $nl"
else
	rm -rf $bb4/kirin970-hikey970.dtb
	cp -avrf $devtre $bb4/
	echo "$gb $bt DEVICE TREE Copied $nl"
fi
echo "$gb $bt INSTALL MODULES $nl"
	cd $tc
	export PATH=$(pwd)/gcc-arm-8.2/bin/:$PATH
	export CROSS_COMPILE=$(pwd)/gcc-arm-8.2/bin/aarch64-linux-gnu-
	aarch64-linux-gnu-gcc --version
	cd $ksrc1
	export ARCH=arm64
	make ARCH=arm64 INSTALL_MOD_PATH=$bb3/ modules_install
}

INIT1 () {
echo "$gb $bt INITIALIZE SYSTEM $nl"
echo "$gb $bt UPDATE /etc/apt/sources.list $nl"
cp -arv $bf/sources.list $bb23
echo "$gb $bt COPY INIT.SH FOR SETUP $nl"
cp -arv $bf/init.sh $bb5
chmod 755 $bb5/init.sh
echo "$yt Set Language -->>$nl" 
echo "$gt Default Language US English $nl"
sudo chroot $bb3 /root/locale.sh
echo "gt Locale set $nl"
stop1
sudo chroot $bb3 /root/init.sh
stop1
}

### Command to download required ubuntu sources
DLSRC () {
DISTRO=${DISTRO:-"bionic"}
MIRRORS=${MIRRORS:-}
SOFTWARE=${SOFTWARE:-"ssh,zsh,wget,tasksel,gnupg2,tmux,nano,linux-firmware,vim-nox,net-tools,wpasupplicant,network-manager,parted,fakeroot,kernel-wedge,build-essential"}
qemu-debootstrap --arch arm64 --include=$SOFTWARE --components=main,multiverse,universe $DISTRO $bb3 $mirror
}

##################################### MAIN MENU #####################################
SMM () {
    clear               
	BIOBAN
	MAMN     
    echo "${bd}${bb}${yt} MAKE CHOICE AND PRESS ENTER. $nl"

    while [ 1 ]
    do
        read CHOICE
        case "$CHOICE" in

            "1") ### Build Base Filesystem
                echo "$bb Checking For Previous Build $nl"
				echo ""
				### Find Exsisting Build allow rename or delete
				FRDS
				### Make the rootfs directories
				MRTFS
				### Copy Files to the directories
				CPFS
				### Banner for downloading the src
				SRCBAN
				### Download the source
                DLSRC
				### INITIALIZE ROOTFS
				INIT1
				### SHOW COMPLETED
				INIBAN
				### Show the main menu
                SMM
                ;;

            "2") ### Build Kernel
                clear
				if [[ ! -d $tc ]]; then
					SETTC
				else
					echo "$gb $bt $bd Toolchain-Found  $nl"
					
				fi
				if [[ ! -d $ksrc ]]; then
					DLKER
				else
					echo "$gb $bt $bd Kernel_SRC-Found $nl"	
				fi
				BLDKER
				SMM
                ;;
            
            "3") ### INSTALL THE KERNEL
				echo "$bb INSTALL KERNEL $nl"
				KERBAN2
				stop1
				INSKER
				CMP
				SMM
                ;;
            
            "4") ### Make Flashable Image
					echo "$bb Make Flashable Image $nl"
				MKIMG
				stop1
				SMM
                ;;
            
            "5") ### Make Flashable Image
				echo "$bb Make Flashable Image $nl"
				MKIMG
				stop1
				SMM
                ;;

            "6") 
                ;;

            "99")
				clear
                exit 0
                ;;
        esac
    done
}

KERBAN () {
echo "$yt"
echo "	 ____        _ _     _       _  __                    _"
echo "        | __ ) _   _(_) | __| |     | |/ /___ _ __ _ __   ___| |"
echo "        |  _ \| | | | | |/ _  |_____| ' // _ \  __|  _ \ / _ \ |"
echo "        | |_) | |_| | | | (_| |_____| . \  __/ |  | | | |  __/ |"
echo "        |____/ \__,_|_|_|\__,_|     |_|\_\___|_|  |_| |_|\___|_|"
echo ""
echo "	$bb        KERNEL BUILDING HIKEY970 V4.9.78 Linux Kernel $nl"
echo ""
echo ""
echo "$bb $yt Kernel Build Choices $nl"
echo ""
echo "$yt Press B to Build The Kernel $nl"
echo ""
echo "$yt Press C to Configure Then Build $nl"
echo " "
echo "$yt Press O to Build with last Configuration $nl"
echo ""
echo "$yt Press X to RETURN TO MAIN MENU $nl"
echo ""
echo ""
echo "$nl"
}

INIBAN () {
echo $gt
clear
echo "'	 ___       _ _         ____                      _      _		 '"
echo "'	|_ _|_ __ (_) |_      / ___|___  _ __ ___  _ __ | | ___| |_ ___	  "
echo "'	 | ||  _ \| | __|____| |   / _ \|  _   _ \|  _ \| |/ _ \ __/ _ \ '"
echo "'	 | || | | | | ||_____| |__| (_) | | | | | | |_) | |  __/ ||  __/ '"
echo " 	|___|_| |_|_|\__|     \____\___/|_| |_| |_| .__/|_|\___|\__\___|  "
echo "                                           	  |_|					  "
echo ""
echo "		    $bb INITIAL ROOTFS SETUP IS COMPLETE $nl"
echo "$gt $bd 		  THERE IS NO NEED TO RUN OPTION 1 AGAIN $nl"
echo "$gt $bd 		 	THE BUILD FILES ARE LOCATED @ $nl"
echo "$yt $bd		$bb2  $nl"
echo ""
echo ""
echo "	$rt   JUST REMEMBER THERE IS NO NEED TO RUN OPTION 1 AGAIN $nl"
stop1
}

TCBAN () {
echo $yt $it
echo "              _____           _        ____ _           _		"
echo "             |_   _|__   ___ | |      / ___| |__   __ _(_)_ __	"
echo "               | |/ _ \ / _ \| |_____| |   |  _ \ / _  | |  _ \	"
echo "               | | (_) | (_) | |_____| |___| | | | (_| | | | | |	"
echo "               |_|\___/ \___/|_|      \____|_| |_|\__ _|_|_| |_|	"
echo "$nl"
echo "	    $bb AUTOMATIC DOWNLOAD INSTALL AND SETUP OF ARM 64 TOOLCHAIN $nl"
echo "$gt 	https://developer.arm.com/open-source/gnu-toolchain/gnu-a/downloads $nl"
echo "$yt 		USING gcc-arm-8.2-2019.01-x86_64-aarch64-linux-gnu $nl"
stop1
}

USEBAN () {
clear
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
clear
echo " 	  ____ _                            __  __ _"
echo " 	 / ___| |__   ___   ___  ___  ___  |  \/  (_)_ __ _ __ ___  _ _	"
echo "	| |   | '_ \ / _ \ / _ \/ __|/ _ \ | |\/| | | '__| '__/ _ \| '__|"
echo "	| |___| | | | (_) | (_) \__ \  __/ | |  | | | |  | | | (_) | |"	 
echo "	 \____|_| |_|\___/ \___/|___/\___| |_|  |_|_|_|  |_|  \___/|_|"
echo "$nl"
echo "$bb USE A MIRRIOR THAT HAS ARM 64 PACKAGES FOR DOWNLOADING THE SRC PACKAGES $nl"
echo "	$yt Go To https://launchpad.net/ubuntu/+archivemirrors      $nl"
echo "	$gt THE WORKING ARM64 MIRRORS ARE LISTED $nl"
echo ""
echo ""
}

SRCBAN () {
echo $yt
clear
echo ""
echo "			 ____  _         ____  ____   ____"
echo "			|  _ \| |       / ___||  _ \ / ___|"
echo "			| | | | |   ____\___ \| |_) | |"
echo "			| |_| | |__|_____|__) |  _ <| |___"
echo "			|____/|_____|   |____/|_| \_\\____|"
echo ""
echo "		$bb DOWNLOADING SOURCE PACKAGES FROM THE MIRROR $nl"
echo "$rt $bd 		DEPENDING ON INTERNET SPEED THIS MAY TAKE A WHILE $nl"
echo ""
stop1
}

KERBAN2 () {
echo $yt
clear
echo "        ___           _        _ _           _  __                    _"
echo "       |_ _|_ __  ___| |_ __ _| | |         | |/ /___ _ __ _ __   ___| |"
echo "        | ||  _ \/ __| __/ _  | | |  _____  |   // _ \  __|  _ \ / _ \ |"
echo "        | || | | \__ \ || (_| | | | |_____| | . \  __/ |  | | | |  __/ |"
echo "       |___|_| |_|___/\__\__,_|_|_|         |_|\_\___|_|  |_| |_|\___|_|"
echo ""
echo "		 $bb COPYING KERNEL / DEVICE TREE & INSTALLING MODULES $nl"
echo "$bb 	NEXT USE OPTION 4 TO GENERATE IMAGE THEN OPTION 5 TO FLASH HIKEY970 $nl"
echo ""
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
### Check required packages
echo "Dependency check"
for i in $REQUIRED; do
	command -v $i >/dev/null 2>&1 || { echo >&2 "require $i but it's not installed.  Aborting."; exit 1; }
	echo "[$i ... OK]"
done
### Call The Main Menu
SMM
exit 0
