#!/bin/sh
userr="vakandi"
echo "Use this command before to setup the right firmware:\n"
echo "cp adafruit-circuitpython-raspberry_pi_pico-en_US-8.0.4.uf2 /media/$userr/RPI-RP2"                                                                                               0:12
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
