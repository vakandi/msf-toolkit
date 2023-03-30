#!/bin/sh
userr="vakandi"
# Set the device name to match your Raspberry Pi
device_name="RPI-RP2"
mount_path="/media/$userr"

echo "Plug the Raspberry Pico now and mount it, \n Waiting for the $device_name ...." 

while true; do
	folder_path="$mount_path/$device_name"
	
	if [ -d "${folder_path}" ]; then
	    file_count=$(ls -1 "${folder_path}" | wc -l)
	
	    if [ "${file_count}" -gt 1 ]; then
	        echo "$device_name Found! Starting the script..."
		break
	    else
	        echo "Your Raspberry pico is not properly mounted, it is missing some standard file in it."
		exit
	    fi
	else
	    echo "."
	fi
 
	sleep 1
done

sleep 2s
cp pico-ducky/adafruit-circuitpython-raspberry_pi_pico-en_US-8.0.4.uf2 /media/$userr/$device_name

echo "Waiting for the Raspberry to Reboot ..."
sleep 2s
echo "\n\nYou need to mount it since the Raspberry Pi Pico is now named 'CircuitPy'..."
sleep 5s
while true; do
	folder_path2="/media/$userr/CIRCUITPY"

	if [ -d "${folder_path2}" ]; then
	    file_count=$(ls -1 "${folder_path2}" | wc -l)
	
	    if [ "${file_count}" -gt 1 ]; then
	        echo "$device_name now renamed CircuitPy Found! Starting Preparation...."
		break
	    fi
	else
	    echo "."
	fi
 
	sleep 1
done



cp -r pico-ducky/adafruit_hid /media/$userr/CIRCUITPY/lib/

cp pico-ducky/adafruit_debouncer.mpy /media/$userr/CIRCUITPY/lib/
cp pico-ducky/adafruit_ticks.mpy /media/$userr/CIRCUITPY/lib/

cp -r pico-ducky/asyncio /media/$userr/CIRCUITPY/lib
cp -r pico-ducky/adafruit_wsgi /media/$userr/CIRCUITPY/lib
cp -r pico-ducky/boot.py /media/$userr/CIRCUITPY/
cp -r pico-ducky/duckyinpython.py /media/$userr/CIRCUITPY/
cp -r pico-ducky/code.py /media/$userr/CIRCUITPY/
cp -r pico-ducky/webapp.py /media/$userr/CIRCUITPY/
cp -r pico-ducky/wsgiserver.py /media/$userr/CIRCUITPY/
sleep 1s
echo "\n\n\n\n \033[42m Finished, you Rubber Ducky is now ready\033[0m"
