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

echo "$gb $bt INITIALIZE SYSTEM $nl"
echo "$gb $bt YOU MUST BE CONNECTED TO THE INTERNET. $nl"
echo ""
echo ""
echo "$gb $bt RESIZING THE ROOT FILESYSTEM $nl"
sudo resize2fs /dev/sdd12
		## The exit status of the last command run is 
		## saved automatically in the special variable $?.
		## Therefore, testing if its value is 0, is testing
		## whether the last command ran correctly.
		if [[ $? > 0 ]]; then
			echo "$rt RESIZING FAILED $nl"
			echo "$rt YOU HAVE TO FIX THIS AND TRY AGAIN $nl"
			stop1
			exit
		else
			echo "$gt RESIZE PARTITION SUCCESSFUL $nl"
			echo "$gt RUNNING APT GET UPDATE $nl"
			stop1
		fi
echo "$gb $bt Get Updates and Upgrade $nl"
echo "$gb $bt Test Internet $nl"

if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
    echo "Internet isn't present"
	inet=0
    exit 1
else
    echo "Internet is present"
	inet=y
fi

	if [[ $inet = "y" ]]; then
		echo "$gt WIFI is Configured $nl"
		sudo apt-get update
		if [[ $? > 0 ]]; then
			echo "$rt APT GET UPDATE FAILED $nl"
			echo "$rt YOU HAVE TO FIX THIS AND TRY AGAIN $nl"
			stop1
			exit
		else
			echo "$gt APT GET UPDATE WAS SUCCESSFUL $nl"
			echo "$gt RUNNING APT GET UPGRADE $nl"
			stop1
		fi
			sudo apt-get upgrade
				if [[ $? > 0 ]]; then
					echo "The command failed, exiting."
					stop1
					exit
				else
					echo "The command ran succesfuly, continuing with script."
					stop1
				fi
	else
			echo "$rt $yb Connect Internet TRY AGAIN $nl"
	fi
sudo apt-get install tasksel
echo "$gb $bt Installing Standard Packages $nl"
sudo tasksel install standard
		
		echo "$gb $bt ENTER Y IF YOU WANT TO INSTALL THE DESKTOP $nl"
		echo ""
		read -n 1 -p "ENTER Y TO INSTALL N TO SKIP $nl $bb Y/N $nl"
			if [[ $REPLY = "y" ]] || [[ $REPLY = "Y" ]]; then
				echo "$gb $bt Installing XFCE4 Desktop $nl"
				sudo apt-get install xubuntu-desktop
					if [[ $? > 0 ]]; then
						echo "$rt INSTALLATION FAILED $nl"
						echo "$rt YOU HAVE TO FIX THIS AND TRY AGAIN $nl"
						stop1
						exit
					else
						echo "$gt INSTALATION SUCCESSFUL $nl"
						echo "$gt YOUR SYSTEM IS READY $nl"
						stop1
					fi
			else
				echo "$gb $bt User Choice NOT TO INSTALL THE DESKTOP $nl"
			fi	
stop1
CMP
exit 0
