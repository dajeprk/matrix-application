#!/bin/bash
clear
GREEN='\033[1;32m'
NONE='\033[0m'

echo -e "${GREEN}Configuring RGB Matrix Settings${NONE}"
echo -e "${GREEN}By running the configureMatrix script again,\nyou can alter the configuration again later.${NONE}"

configure_rows {
	rows_presets=('32' '64' '128')
	echo
	echo -e "0 - 32 pixels per row\n1 - 64 pixels per row\n2 - 128 pixels per row\n3 - Custom # of pixels per row"
	echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
	read tmp
	if [[ tmp -eq 3 ]]; then
		echo -e -n "${GREEN}Enter the custom # of pixels per row: ${NONE}"
		read rows
	else 
		rows=${rows_presets[$tmp]}
	fi
;}

configure_rows

cols_presets=('32' '64' '128')
echo
echo -e "0 - 32 pixels per column\n1 - 64 pixels per column\n2 - 128 pixels per column\n3 - Custom # of pixels per column"
echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
read tmp
if [[ tmp -eq 3 ]]; then
	echo -e -n "${GREEN}Enter the custom # of pixels per column: ${NONE}"
	read cols
else
	cols=${cols_presets[$tmp]}
fi

hardware_presets=('regular' 'adafruit-hat' 'adafruit-hat-pwm' 'compute-module')
echo
echo -e "0 - regular hardware mapping\n1 - adafruit hat hardware mapping\n2 - adafruit hat with hardware mod mapping\n3 - compute module mapping"
echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
read tmp
hardware_mapping=${hardware_presets[$tmp]}

echo
echo -e "0 - defualt value for parallel (1)\n1 - custom value for parallel"
echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
read tmp
if [[ tmp -eq 0 ]]; then
	parallel = 1
elif [[ tmp -eq 1 ]]; then
	echo -e -n "${GREEN}Enter a custom value between 1 - 3. (6 for compute module): ${NONE}"
	read parallel
fi

echo
echo -e "0 - default value for chain (1)\n1 - custom value for chain"
echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
read tmp
if [[ tmp -eq 0 ]]; then
	chain = 1
elif [[ tmp -eq 1 ]]; then
	echo -e -n "${GREEN}Enter the # of chained panels: ${NONE}"
	read chain
fi

echo
echo -e "0 - default value for GPIO slowdown (2)\n1 - custom value for GPIO slowdown"
echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
read tmp
if [[ tmp -eq 0 ]]; then
	gpio_slowdown = 2
elif [[ tmp -eq 1 ]]; then
	echo -e -n "${GREEN}Enter a custom value between 0 - 4: ${NONE}"
	read gpio_slowdown
fi

echo
echo $rows
echo $cols
echo $hardware_mapping
echo $parallel
