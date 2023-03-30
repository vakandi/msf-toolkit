#!/bin/sh
userr="vakandi"
# Set the device name to match your Raspberry Pi
device_name="RPI-RP2"
echo "Plug the Raspberry Pico now and mount it, \n Waiting for the $device_name ...." 
while true; do
    # Check if the device is mounted
    if grep -qs "/dev/${device_name}" /proc/mounts; then
        echo "Device ${device_name} is mounted!"
        break
    fi
    sleep 1
done

cp adafruit-circuitpython-raspberry_pi_pico-en_US-8.0.4.uf2 /media/$userr/$device_name

echo "Sleep 20s..."
sleep 20s

echo "If you already did, type yes"
read choice
if [ $choice = "yes" ]
then
	cp -r adafruit_hid /media/$userr/CIRCUITPY/lib/

	cp adafruit_debouncer.mpy /media/$userr/CIRCUITPY/lib/
	cp adafruit_ticks.mpy /media/$userr/CIRCUITPY/lib/
	
	cp -r asyncio /media/$userr/CIRCUITPY/lib
	cp -r adafruit_wsgi /media/$userr/CIRCUITPY/lib
	cp -r boot.py /media/$userr/CIRCUITPY/
	cp -r duckyinpython.py /media/$userr/CIRCUITPY/
	cp -r code.py /media/$userr/CIRCUITPY/
	cp -r webapp.py /media/$userr/CIRCUITPY/
	cp -r wsgiserver.py /media/$userr/CIRCUITPY/
else
	echo "exiting.."
	exit
fi
