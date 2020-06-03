#!/bin/bash

function __kobman_install_KOBman
{
	local environment_name="$1"
	local version_id="$2"	
	
	cd ~
	if [ ! -d "Dev_KOBman" ]; then 
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		__kobman_create_dev_environment "${environment_name}" "${version_id}"  
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null	
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	else
 		__kobman_echo_white "Removing existing version "
		rm -rf ~/Dev_"${environment_name}"	
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		__kobman_create_dev_environment "${environment_name}" "${version_id}"  
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null	
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	fi		

	cd ~

}



function __kobman_create_dev_environment 
{
	local environment="$1"	
	local version_id="$2"	
	cd ~
	mkdir -p Dev_"${environment}"
	cd Dev_"${environment}"
	export "${environment}"_DEV_DIR=$PWD
	mkdir -p test/ dependency/
}
