#!/bin/bash

function hr {
	echo "--------------------------------------------------------------------------------"
}

function headline {
	username=$(whoami)
	hostname=$(hostname)
	workdir=$(pwd)
	echo $username@$hostname:$workdir
}

function SystemTab {
	while [ true ]; do
		clear
		headline
		echo "0) back"
		echo "1) osinfo"
		echo "2) cpu"
		echo "3) memory"
		echo "4) usb"
		echo "5) processes"
		hr
		
		read -n1 ans2
		echo ""
		if [ $ans2 == 0 ]; then
			break
		elif [ $ans2 == 1 ]; then
			uname -a
		elif [ $ans2 == 2 ]; then
			lscpu
		elif [ $ans2 == 3 ]; then
			free
		elif [ $ans2 == 4 ]; then
			lsusb
		fi
		
		read -n1 r
	done
}

function NumbersMode {
	while [ true ]; do
		clear
		headline
		echo "0) exit"
		echo "1) system"
		echo "2) files"
		echo "3) network"
		echo "4) packages"
		hr
		
		read -n1 ans2
		echo ""
		if [ $ans2 == 0 ]; then
			break
		elif [ $ans2 == 1 ]; then
			SystemTab
		elif [ $ans2 == 3 ]; then
			ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
		fi
		
		read -n1 r
	done
}

clear
echo "Welcome to G-SHELL"
echo ""
echo "Select an operating mode"
echo "1) Numbers Mode"
echo "2) Interactive Mode"
echo ""

read -n1 ans

if [ $ans == 1 ]; then
	NumbersMode	
else
	echo "interactive mode not implemented yet"
fi;