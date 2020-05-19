#!/bin/bash

function __kobman_development_tobvon_dir 
{
	cd ~	
	mkdir -p Dev_TOBVon
	cd Dev_TOBVon
	export KOBMAN_VON_DEV_DIR=$PWD
	cd ${KOBMAN_VON_DEV_DIR}
	mkdir -p test/ dependency/
	if [ ! -d "${KOBMAN_VON_DEV_DIR}/von-network" ]
	then
		__kobman_install_dependancies
        fi
}                                                                                                                          
function __kobman_install_tobvon
{
	kobman_namespace="$1"	
 	__kobman_echo_white "Downloading Verifiable Organizations Network environment from Github namespace : "	
	__kobman_echo_green " ${kobman_namespace}"
	cd ~	
	__kobman_development_tobvon_dir 
	git clone https://github.com/${kobman_namespace}/von-network.git
        von-network/manage rm
        von-network/manage build
	cd ~
}
function __kobman_start_tobvon
{

 	__kobman_echo_white "Deploying Verifiable Organizations Network environment from Github namespace : "	
	__kobman_echo_green "${kobman_namespace}"
        cd ${KOBMAN_VON_DEV_DIR} 
	von-network/manage start
}

function __kobman_uninstall_tobvon
{
 	__kobman_echo_white "Removing Verifiable Organizations Network environment...  "	
	cd ${KOBMAN_VON_DEV_DIR} 
	rm -rf von-network/ 2> /dev/null	
	cd ~
	rm -rf Dev_TOBVon/ 2> /dev/null	
	rm -rf ${KOBMAN_VON_DEV_DIR} 2> /dev/null	
 	__kobman_echo_red "Verifiable Organizations Network environment removed !! "	
	cd ~
}

function __kobman_version_tobvon
{
	if [ -d "${KOBMAN_TOBVON_DEV_DIR}" ]
	then 
		kobman_namespace="$1"
		cd ${KOBMAN_VON_DEV_DIR} 
		cd von-network/	
		git show-ref --tag | grep -o v0.0.*
		cd ~
	else
 		__kobman_echo_red " Verifiable Organizations Network environment is not installed in the Local system !"	
	fi
}
