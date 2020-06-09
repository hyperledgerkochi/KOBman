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
		__kobman_create_dev_environment "${environment_name}"
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	else
 		__kobman_echo_white "Removing existing version "
		rm -rf ~/Dev_"${environment_name}"
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		__kobman_create_dev_environment "${environment_name}"
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	fi

	cd ~

}

<<<<<<< HEAD
function __kobman_create_dev_environment
=======



#################newly incorporated code from kobma-dependancy.sh################




function __kobman_create_dev_environment 
>>>>>>> 0ca31736b3bf96abd68fdf1642d9dc2c1b32f220
{
	local environment="$1"

	cd ~
	mkdir -p Dev_"${environment}"
	cd Dev_"${environment}"
	export Dev_${environment}=$PWD
	mkdir -p test/ dependency/
}
<<<<<<< HEAD
=======
	



################################old codes to refer if required ################




>>>>>>> 0ca31736b3bf96abd68fdf1642d9dc2c1b32f220



#function __kobman_uninstall_kobman
#{
# 	__kobman_echo_white "Removing KOBman environment..."
<<<<<<< HEAD
#	cd ${KOBMAN_KOBMAN_DEV_DIR}
#	rm -rf KOBman/ 2> /dev/null
#	cd ~
#	rm -rf Dev_KOBman/ 2> /dev/null
#	rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null
#        cd ~
#	__kobman_echo_red "KOBman environment removed !!"
=======
#	cd ${KOBMAN_KOBMAN_DEV_DIR} 
#	rm -rf KOBman/ 2> /dev/null	
#	cd ~
#	rm -rf Dev_KOBman/ 2> /dev/null	
#	rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null	
#        cd ~
#	__kobman_echo_red "KOBman environment removed !!"	
>>>>>>> 0ca31736b3bf96abd68fdf1642d9dc2c1b32f220
#}
#
#function __kobman_version_kobman
#{
<<<<<<< HEAD
#	if [ -d "${KOBMAN_KOBMAN_DEV_DIR}" ]; then
##		namespace="$1"
##		cd ${KOBMAN_KOBMAN_DEV_DIR}
##		cd KOBman/
=======
#	if [ -d "${KOBMAN_KOBMAN_DEV_DIR}" ]; then 
##		namespace="$1"
##		cd ${KOBMAN_KOBMAN_DEV_DIR} 
##		cd KOBman/	
>>>>>>> 0ca31736b3bf96abd68fdf1642d9dc2c1b32f220
##		git show-ref --tag | grep -o v0.0.*
# #		cd "${KOBMAN_DIR}"/var
#		cd "${KOBMAN_DIR}/var"
#                cat version.txt
#                cd ~
#	else
<<<<<<< HEAD
# 		__kobman_echo_red "KOBman Environment is not installed in the Local system !"
#fi
#
#}
=======
# 		__kobman_echo_red "KOBman Environment is not installed in the Local system !"	
#fi
#
#}
#
>>>>>>> 0ca31736b3bf96abd68fdf1642d9dc2c1b32f220
