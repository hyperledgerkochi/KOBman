#!/usr/bin/env bash


function __kob_install {

	local environment_value=$1
 	local version_value=$2
	__kobman_create_environment_directory "$environment_value" "$version_value" 
}

function __kobman_validate_environment
{
	echo $1 > $KOBMAN_DIR/var/current	
	__kobman_secure_curl "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/list.txt" | grep -w "$1" > /dev/null 

	if [ "$?" != "0" ]; then 

		__kobman_echo_green "environment does not exist" 
		return 1 
	fi 
}

function __kobman_validate_version_format
{
	__kobman_echo_no_colour "$1" | grep -w '[0-9].[0-9].[0-9]' > /dev/null

	if [ "$?" != "0" ]; then 

		__kobman_echo_debug "Version format you have entered is incorrect" 
		__kobman_echo_green "Correct format -> 0.0.0 [eg: 0.0.2]" 
		return 1 
	fi 
}

function __kobman_check_if_version_exists
{
	local environment_name=$1
	local version=$2
#	local namespace=$3	
	__kobman_secure_curl "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/list.txt" | grep -w "${environment_name}" | grep -q ${version} 

	if [ "$?" != "0" ]; then 

		__kobman_echo_debug "version does not exist" 
		return 1 
	fi 
}


function __kobman_create_environment_directory
{

		local environment_name=$1
		local version_id=$2 
		
		cd "${KOBMAN_DIR}/envs"
                mkdir -p kob_env_"${environment_name}"
                cd kob_env_"${environment_name}"
                touch current
		destdir="${KOBMAN_DIR}/envs/kob_env_${environment_name}/current"
                
               	if [ ! -d "$version_id" ] 
		then	
			mkdir -p $version_id
                	cd $version_id                                          # Needs to be refactored identify the latest version 
                	__kobman_echo_no_colour "$version_id" > "$destdir"
      			cp "${KOBMAN_DIR}/envs/kobman-${environment_name}.sh" .
                	source "${KOBMAN_DIR}/envs/kob_env_${environment_name}/${version_id}/kobman-${environment_name}.sh"
			__kobman_install_"${environment_name}" "${environment_name}" "${version_id}"  
			cd ~
               	elif [ -d "$version_id" ]  && [ $(cat $destdir) != "$version_id" ] 
		then	
			cd ~	
			__kobman_echo_no_colour "Re-installing  https://github.com/${KOBMAN_NAMESPACE}/${environment_name} with version:${version_id} "
                	__kobman_echo_no_colour "$version_id" > "$destdir"
			__kobman_install_"${environment_name}" "${environment_name}" "${version_id}"  
			return 1	
		else
			__kobman_echo_white "Version ${version_id} of https://github.com/${KOBMAN_NAMESPACE}/${environment_name} is currently installed in your system "
			cd ~
		fi
}
