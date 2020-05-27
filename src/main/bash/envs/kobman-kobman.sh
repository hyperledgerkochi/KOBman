#!/bin/bash
function __kobman_development_kobman_dir { 
	cd ~
	if [ ! -d "${KOBMAN_KOBMAN_DEV_DIR}" ]; then 
		mkdir -p Dev_KOBman
		cd Dev_KOBman
		export KOBMAN_KOBMAN_DEV_DIR=$PWD
		cd ${KOBMAN_KOBMAN_DEV_DIR}
		mkdir -p test/ dependency/
               	__kobman_echo_cyan "Copying source code  of https://github.com/${kobman_namespace}/${confirmed_environment} to your local system ! "
	else
               	__kobman_echo_red "Source code of https://github.com/${kobman_namespace}/${confirmed_environment} already existing in your local system ! "
	fi
}

function __kobman_install_kobman
{
	kobman_namespace="$1"
	cd ~
       	__kobman_development_kobman_dir 
	git clone https://github.com/${kobman_namespace}/KOBman.git 2> /dev/null	
	cd ~
}

function __kobman_uninstall_kobman
{
 	__kobman_echo_white "Removing KOBman environment..."
	cd ${KOBMAN_KOBMAN_DEV_DIR} 
	rm -rf KOBman/ 2> /dev/null	
	cd ~
	rm -rf Dev_KOBman/ 2> /dev/null	
	rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null	
        cd ~
	__kobman_echo_red "KOBman environment removed !!"	
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
 		__kobman_echo_red "KOBman Environment is not installed in the Local system !"	
fi

}

