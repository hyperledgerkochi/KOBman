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




#################newly incorporated code from kobma-dependancy.sh################




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
	



################################old codes to refer if required ################







#function __kobman_uninstall_kobman
#{
# 	__kobman_echo_white "Removing KOBman environment..."
#	cd ${KOBMAN_KOBMAN_DEV_DIR} 
#	rm -rf KOBman/ 2> /dev/null	
#	cd ~
#	rm -rf Dev_KOBman/ 2> /dev/null	
#	rm -rf ${KOBMAN_KOBMAN_DEV_DIR} 2> /dev/null	
#        cd ~
#	__kobman_echo_red "KOBman environment removed !!"	
#}
#
#function __kobman_version_kobman
#{
#	if [ -d "${KOBMAN_KOBMAN_DEV_DIR}" ]; then 
##		namespace="$1"
##		cd ${KOBMAN_KOBMAN_DEV_DIR} 
##		cd KOBman/	
##		git show-ref --tag | grep -o v0.0.*
# #		cd "${KOBMAN_DIR}"/var
#		cd "${KOBMAN_DIR}/var"
#                cat version.txt
#                cd ~
#	else
# 		__kobman_echo_red "KOBman Environment is not installed in the Local system !"	
#fi
#
#}
#
