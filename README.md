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
	
	1) Please cd to your main prompt The files need to be cloned to ~/ 
		Then clone the repo.
		git clone https://github.com/Bigcountry907/Bionic-Builder.git
		
Thank You 
I hope you enjoy the Hikey970 Bionic-Builder
BigCountry907
