#!/bin/bash 

function __kobman_development_greenlight_dir {
	cd ~
	mkdir -p Dev_greenlight
	cd Dev_greenlight
	export KOBMAN_GREENLIGHT_DEV_DIR=$PWD
	cd ${KOBMAN_GREENLIGHT_DEV_DIR}
	mkdir -p test/ dependency/
	if [ ! -d "${KOBMAN_VON_DEV_DIR}/von-network" ]
	then
		__kobman_install_dependancies
        fi
}

function __kobman_install_greenlight
{
	kobman_namespace="$1"
 	__kobman_echo_white "Downloading Greenlight environment from Github namespace : "	
	__kobman_echo_green " ${kobman_namespace}"
       	cd ~ 
	__kobman_development_greenlight_dir 
	git clone https://github.com/${kobman_namespace}/greenlight.git
        wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        mv s2i sti /usr/local/bin/
        ${KOBMAN_GREENLIGHT_DEV_DIR}/greenlight/docker/manage rm
        ${KOBMAN_GREENLIGHT_DEV_DIR}/greenlight/docker/manage build
	cd ~
}

function __kobman_start_greenlight
{
 	__kobman_echo_white "Deploying Greenlight environment from Github namespace : "	
	__kobman_echo_green "${kobman_namespace}"
       	chmod a+rwx ${KOBMAN_GREENLIGHT_DEV_DIR}
	${KOBMAN_GREENLIGHT_DEV_DIR}/greenlight/docker/manage start
}

function __kobman_uninstall_greenlight
{
 	__kobman_echo_white "Removing Greenlight environment...  "	
       	sudo chmod 777 ${KOBMAN_GREENLIGHT_DEV_DIR}
	cd ${KOBMAN_GREENLIGHT_DEV_DIR} rm 2> /dev/null	
	greenlight/docker/manage rm 2> /dev/null	
	rm -rf greenlight/ 2> /dev/null	
	rm -rf greenlight/ /usr/local/bin/sti /usr/local/bin/s2i source-to-image-v1.1.14-874754de-linux-amd64.tar.gz 2> /dev/null	
        cd ~
       	rm -rf ${KOBMAN_GREENLIGHT_DEV_DIR} 2> /dev/null
 	__kobman_echo_red "Greenlight environment removed !! "	
        cd ~
}

function __kobman_version_greenlight
{
	if [ -d "${KOBMAN_GREENLIGHT_DEV_DIR}" ]; then 
		kobman_namespace="$1"
		cd ${KOBMAN_GREENLIGHT_DEV_DIR} 
		cd greenlight/	
		git show-ref --tag | grep -o 0.0.*
		cd ~
	else
 		__kobman_echo_green "Greenlight is not installed ! "	
	fi
}
