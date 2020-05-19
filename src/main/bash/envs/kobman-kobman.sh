#!/bin/bash
function __kobman_development_kobman_dir {

	cd ~
	mkdir -p Dev_KOBman
	cd Dev_KOBman
	export KOBMAN_KOBMAN_DEV_DIR=$PWD
	cd ${KOBMAN_KOBMAN_DEV_DIR}
	sudo mkdir -p test/ dependency/
}

function __kobman_install_kobman
{
	kobman_namespace="$1"
 	__kobman_echo_green "Building kobman from"	
 	__kobman_echo_green "${kobman_namespace}"	
	cd ~
       	__kobman_development_kobman_dir 
	sudo git clone https://github.com/${kobman_namespace}/KOBman.git
	cd ~
	__kobman_echo_green "KOBman Development Environment is installed."	
}

function __kobman_uninstall_kobman
{
 	__kobman_echo_green "KOBman - Uninstalling..."
	cd ${KOBMAN_KOBMAN_DEV_DIR} 
	sudo rm -rf KOBman/ 2> /dev/null	
	cd ~
	sudo rm -rf Dev_KOBman/ 2> /dev/null	
	sudo rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null	
        cd ~
	__kobman_echo_green "KOBman Development Environment is un-installed."	
}

function __kobman_version_kobman
{
	if [ -d "${KOBMAN_KOBMAN_DEV_DIR}" ]; then 
#		kobman_namespace="$1"
#		cd ${KOBMAN_KOBMAN_DEV_DIR} 
#		cd KOBman/	
#		git show-ref --tag | grep -o v0.0.*
 #		cd "${KOBMAN_DIR}"/var
		cd "${KOBMAN_DIR}/var"
                cat version.txt
                cd ~
	else
 		__kobman_echo_green "KOBman is not installed"	
fi

}

