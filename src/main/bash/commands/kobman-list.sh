#!/bin/bash

function __kob_list {
	curl -sL "https://raw.githubusercontent.com/asa1997/KOBman/dev/dist/list.txt" > tmp.txt

#	curl -sL "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/dev/dist/list.txt" > tmp.txt
#	if [ "$?" -eq "0" ];
#	then	
		__kobman_echo_cyan "Available environments & their respective version numbers"
		__kobman_echo_cyan "---------------------------------------------------------  "
		sed 's/,/ /g' tmp.txt > tmp1.txt
		sed 's/,/ /g' tmp.txt | cut -d " " -f 1 > tmp2.txt
		cat tmp1.txt | grep -h -f tmp2.txt > tmp3.txt
		cat tmp3.txt
		rm tmp*
#	else
#               	__kobman_echo_red "List is not available at https://github.com/${namespace}/KOBman "
#	fi
}
