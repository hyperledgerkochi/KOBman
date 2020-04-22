#!/bin/bash
function __kobman_development_kobman_dir {

	cd ~
	  mkdir -p Dev_KOBman
	cd Dev_KOBman
	export KOBMAN_KOBMAN_DEV_DIR=$PWD
	  chmod 777 ${KOBMAN_KOBMAN_DEV_DIR}
	cd ${KOBMAN_KOBMAN_DEV_DIR}
	  mkdir -p test/ dependency/
}

function __kobman_install_kobman
{
	cd "${KOBMAN_DIR}/envs"
	mkdir kobman
	cd kobman
	touch current
	cat "${KOBMAN_DIR}/var/version.txt" > current	
	echo "displaying kobman current"
	cat current	
	kobman_namespace="$1"
 	__kobman_echo_green "Building kobman from"	
 	__kobman_echo_green "${kobman_namespace}"	
	cd ${KOBMAN_CANDIDATES_DIR}
       	__kobman_development_kobman_dir 
	  git clone https://github.com/${kobman_namespace}/KOBman.git
	cd ~
	cd ${KOBMAN_CANDIDATES_DIR}
	__kobman_echo_green "KOBman Development Environment is installed."	
}

function __kobman_uninstall_kobman
{
 	__kobman_echo_green "KOBman - Uninstalling..."
	cd ${KOBMAN_KOBMAN_DEV_DIR} 
	  rm -rf KOBman/ 2> /dev/null	
	cd ~
	  rm -rf Dev_KOBman/ 2> /dev/null	
	  rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null	
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

