#!/bin/bash
clear
GREEN='\033[1;32m'
NONE='\033[0m'

echo -e "${GREEN}Configuring RGB Matrix Settings${NONE}"
echo -e "${GREEN}By running the configureMatrix script again,\nyou can alter the configuration again later.\nPress [Enter] on prompt for default values.${NONE}"

configure_rows () {
	rows_presets=('32' '64' '128')
	echo
	echo -e "0 - 32 pixels per row\n1 - 64 pixels per row\n2 - 128 pixels per row\n3 - Custom # of pixels per row"
	echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
	read tmp
	if [[ tmp -eq 3 ]]; then
		echo -e -n "${GREEN}Enter the custom # of pixels per row: ${NONE}"
		read rows
	elif [[ tmp -lt ${#rows_presets[@]} && tmp -ge 0 ]]; then 
		rows=${rows_presets[$tmp]}
	else
		echo -e "${GREEN}Value entered is not between 0 - 3.${NONE}"
		configure_rows
	fi
}

configure_rows

configure_cols () {
	cols_presets=('32' '64' '128')
	echo
	echo -e "0 - 32 pixels per column\n1 - 64 pixels per column\n2 - 128 pixels per column\n3 - Custom # of pixels per column"
	echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
	read tmp
	if [[ tmp -eq 3 ]]; then
		echo -e -n "${GREEN}Enter the custom # of pixels per column: ${NONE}"
		read cols
	elif [[ tmp -lt ${#cols_presets[@]} && tmp -ge 0 ]]; then
		cols=${cols_presets[$tmp]}
	else
		echo -e "${GREEN}Value entered is not between 0 - 3.${NONE}"
		configure_cols
	fi
}

configure_cols

configure_hardware () {
	hardware_presets=('regular' 'adafruit-hat' 'adafruit-hat-pwm' 'compute-module')
	echo
	echo -e "0 - regular hardware mapping\n1 - adafruit hat hardware mapping\n2 - adafruit hat with hardware mod mapping\n3 - compute module mapping"
	echo -e -n "${GREEN}\nEnter value between 0 - 3: ${NONE}"
	read tmp
	if [[ tmp -lt ${#hardware_presets[@]} && tmp -ge 0 ]]; then
		hardware_mapping=${hardware_presets[$tmp]}
	else
		echo -e "${GREEN}Value entered is not between 0 - 3.${NONE}"
		configure_hardware
	fi
}

configure_hardware

configure_parallel () {
	echo
	echo -e "0 - defualt value for parallel (1)\n1 - custom value for parallel"
	echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
	read tmp
	if [[ tmp -eq 0 ]]; then
		parallel=1
	elif [[ tmp -eq 1 ]]; then
		echo -e -n "${GREEN}Enter a custom value between 1 - 3. (6 for compute module): ${NONE}"
		read parallel
		if [[ parallel -ne 6 && parallel -gt 3 || parallel -lt 1 ]]; then
			echo -e "${GREEN}Value entered is not 6 or between 1 - 3.${NONE}"
			configure_parallel
		fi
	else
		echo -e "${GREEN}Value entered is not between 0 - 1.${NONE}"
		configure_parallel
	fi
}

configure_parallel

configure_chain () {
	echo
	echo -e "0 - default value for chain (1)\n1 - custom value for chain"
	echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
	read tmp
	if [[ tmp -eq 0 ]]; then
		chain=1
	elif [[ tmp -eq 1 ]]; then
		echo -e -n "${GREEN}Enter the # of chained panels: ${NONE}"
		read chain
	else
		echo -e "${GREEN}Value entered is not between 0 - 1.${NONE}"
		configure_chain
	fi
}

configure_chain

configure_gpio () {
	echo
	echo -e "0 - default value for GPIO slowdown (2)\n1 - custom value for GPIO slowdown"
	echo -e -n "${GREEN}\nEnter value between 0 - 1: ${NONE}"
	read tmp
	if [[ tmp -eq 0 ]]; then
		gpio_slowdown=2
	elif [[ tmp -eq 1 ]]; then
		echo -e -n "${GREEN}Enter a custom value between 0 - 4: ${NONE}"
		read gpio_slowdown
		if [[ gpio_slowdown -gt 4 || gpio_slowdown -lt 0 ]]; then
			echo -e "${GREEN}Value entered is not between 0 -4.${NONE}"
			configure_gpio
		fi
	else
		echo -e "${GREEN}Value entered is not between 0 - 1.${NONE}"
		configure_gpio
	fi
}

configure_gpio

echo -e "${GREEN}Generating configuration file.${NONE}"
cd ../config
echo "[DEFAULT]" > matrixOptions.ini
echo "rows = "$rows >> matrixOptions.ini
echo "cols = "$cols >> matrixOptions.ini
echo "chain_length = "$chain >> matrixOptions.ini
echo "parallel = "$parallel >> matrixOptions.ini
echo "hardware_mapping = "$hardware_mapping >> matrixOptions.ini
echo "gpio_slowdown = "$gpio_slowdown >> matrixOptions.ini
echo "brightness = 100" >> matrixOptions.ini
echo "power = on" >> matrixOptions.ini
echo "refresh_rate = 60" >> matrixOptions.ini
echo -e "${GREEN}Configuration file generated.${NONE}"
