# Hikey970 Ubuntu Image
The Bionic-Builder is a all in one tool.
This program will setup everything you need for Hikey970.

	A) The base files needed to build Ubuntu-18.04 for Hikey970.
	B) The Hikey970 Kernel v4.9.78 with modules.
	C) Includes functionality to build kernel and modules + Install them.
	D) Revised to include Wi-Fi Driver Update
	E) Revised to include Modules Install in the Built image
	F) Revised to include Mali GPU Drivers
	G) Includes Partition Table and allows for 59 GB Root Partition
	H) Fixed resize2fs errors.
	I) Includes setup and configuration of latest ARM64 Tool-Chain.
	J) This is a re-write of initial work from:
           https://github.com/mengzhuo/hikey970-ubuntu-image.git

GETTING STARTED

PREREQUSITE Install the require packages.
sudo apt-get install img2simg binfmt-support qemu qemu-user-static debootstrap

Make sure you install img2simg and not android-tools-fsutils.
If the resize2fs /dev/sdd12 # max usage of disk give error during execution it is because you have android-tools-fsutils installed.
Please uninstall android-tools-fsutils and install img2simg. Then you will be able to resise2fs /dev/sdd12.

	To maintain consistent file paths please use the following to begin the setup.
	A) Please run sudo -s to switch to root user before starting the project. BB.sh needs to be run as root user.
		Running sudo ./BB.sh may work but there are many operations that require root.
		The safest way to be sure everything works is to sudo -s before you start.
	
	1) Please cd to your main prompt The files need to be cloned to ~/ 
		Then clone the repo.
		git clone https://github.com/Bigcountry907/Bionic-Builder.git
		
	2) To start the build program first switch to root user.
		sudo -s
		
	3) Run the Program and follow the menus and prompts. To start the program run.
		./BB.sh
	
	4) Basically the menu system is set up in the order things need to be done.
	
		A) Start with #1 to create the rootfs.
		
		B) Run #2 to download and setup the tool chain download the kernel source and build the kernel.
		
		NOTE: You have to build the kernel to make the complete image. If you don't want to build the kernel then you 
		will need to manually copy your kernel Image.gz as Image-hikey970-v4.9.gz 
		and the Device tree to /boot in the image. You also need to copy your modules to /lib/modules.
		
		NOTE2: If you use the Bionic Builder to build the kernel then everything will be automatically installed into 
		the image.
		
		C) Run option #3 after the rootfs and kernel have been created.
		This will install the kernel the device tree and the modules into the image.
		
		D) Run option 4 to generate the flashable image.
		
		E) Copy the image to local machine if built on a server, it will be found in ~/Bionic-Builder/Install.
		If you build on a local machine you can fastboot flash the images from the ~/Bionic-Builder/Install
		directory. I have also included the update_Hikey970.sh update_Hikey970.bat in the /install directory.
		To use the scripts first rename the ubuntu_bionic.hikey970.V-1.0.sparse.img to rootfs.sparse.img.
		then in linux run ./update_Hikey970.sh in windows run update_Hikey970.bat.
		NOTE: (Boot to FASTBOOT to install)	
		Before running the flash scripts be sure to turn switch 3 to on and connect the hikey970 usb-c port next
		to the hdmi.
		
		NOTE: To see the Grub Menu connect the Usb-c port on the side of the board. The usb-c that is by itself with
		nothing else on that side of the board. Use putty or ssh in linux to connect the serial console.
		
Thank You 
I hope you enjoy the Hikey970 Bionic-Builder
BigCountry907
