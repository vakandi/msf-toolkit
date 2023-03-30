#!/bin/sh
userr="vakandi"

cp adafruit-circuitpython-raspberry_pi_pico-en_US-8.0.4.uf2 /media/$userr/RPI-RP2                                                                                                   0:12
sleep 10s
cp -r adafruit_hid /media/$userr/CIRCUITPY/lib/

cp adafruit_debouncer.mpy /media/$userr/CIRCUITPY/lib/
cp adafruit_ticks.mpy /media/$userr/CIRCUITPY/lib/

cp -r asyncio /media/$userr/CIRCUITPY/lib
cp -r adafruit_wsgi /media/$userr/CIRCUITPY/lib
cp -r boot.py /media/$userr/CIRCUITPY/lib
cp -r duckyinpython.py /media/$userr/CIRCUITPY/lib
cp -r code.py /media/$userr/CIRCUITPY/lib
cp -r webapp.py /media/$userr/CIRCUITPY/lib
cp -r wsgiserver.py /media/$userr/CIRCUITPY/lib
