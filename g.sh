#!/bin/bash
#
#	Written by dave0x3e
#	http://invidec.net
#

function hr {
	echo "--------------------------------------------------------------------------------"
}

function headline {
	username=$(whoami)
	hostname=$(hostname)
	workdir=$(pwd)
	echo $username@$hostname:$workdir
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

function SystemTab {
	while [ true ]; do
		clear
		headline
		echo "0) back"
		echo "1) OSInfo"
		echo "2) Cpu"
		echo "3) Memory"
		echo "4) Disk Usage"
		echo "5) Usb"
		echo "6) processes"
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
			df -k
		elif [ $ans2 == 5 ]; then
			lsusb
		fi
		
		read -n1 r
	done
}

function FilesTab {
	while [ true ]; do
		clear
		headline
		echo "0) back"
		echo "1) Create File"
		echo "2) Create Directory"
		echo "3) Delete"
		echo "4) Permissions"
		echo "5) Owner"
		echo "6) GoUp"
		hr
		ls
		
		read -n1 ans2
		echo ""
		if [ $ans2 == 0 ]; then
			break
		elif [ $ans2 == 1 ]; then
			echo "Enter new File Name:"
			read fn
			echo "" > $fn;
			echo "File Created!"
		elif [ $ans2 == 2 ]; then
			echo "Enter new Directory Name:"
			read dn
			mkdir $dn
			echo "Direcotry Created!"
		elif [ $ans2 == 3 ]; then
			echo "Delete WHAT?"
			read dp
			rm -R $dp
		elif [ $ans2 == 4 ]; then
			echo sadf
		elif [ $ans2 == 6 ]; then
			cd ..
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
		elif [ $ans2 == 2 ]; then
			FilesTab
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