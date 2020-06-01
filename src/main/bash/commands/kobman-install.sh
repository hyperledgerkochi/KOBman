#!/usr/bin/env bash


function __kob_install {

	local environment_value=$1
 	local version_value=$2
	local namespace_value=$3 
	__kobman_create_environment_directory "$environment_value" "$version_value" "$namespace_value" 
}

function __kobman_validate_environment
{
	echo $1 > $KOBMAN_DIR/var/current	
	__kobman_secure_curl "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/list.txt" | grep -w "$1" > /dev/null
}

function __kobman_setting_global_variables
{
	environment_value=$1
        version_value=$2
     	namespace_value=$3
}

function __kobman_validate_and_set_version
{
	local environment=$1
	local version=$2
	local namespace=$3	

	__kobman_validate_version_format "${version}" 
	if [ "$?" -eq "0" ];
	then
        	__kobman_check_if_version_exists "${environment}" "${version}" "${namespace}"  	 
        	if [ "$?" -eq "0" ]; then  									 
                	
			version_value=$1
        		return 0	
		else
                	__kobman_echo_debug "Version : ${version} of https://github.com/${namespace}/${environment} not available "
			return 1 
		fi
	else
        	__kobman_echo_debug "Version format you have entered is incorrect"
        	__kobman_echo_green "Correct format -> 0.0.0 [eg: 0.0.2]"
		return 2  
	fi
	

}

function __kobman_validate_version_format
{
	__kobman_echo_no_colour "$1" | grep -w '[0-9].[0-9].[0-9]' > /dev/null

}

function __kobman_check_if_version_exists
{
	local environment_name=$1
	local version=$2
	local namespace=$3	

	__kobman_secure_curl "https://raw.githubusercontent.com/${namespace}/KOBman/master/dist/list.txt" | grep -w "${environment_name}" | grep -q ${version}
}


function __kobman_create_environment_directory
{

		environment_name=$1
		version_id=$2 
        	namespace_name=$3
		
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
			__kobman_install_"${environment_name}" "${environment_name}" "${version_id}" "${namespace_name}" 
			cd ~
               	elif [ -d "$version_id" ]  && [ $(cat $destdir) != "$version_id" ] 
		then	
		
			cd ~	
			__kobman_echo_no_colour "Re-installing  https://github.com/${namespace_name}/${environment_name} with version:${version_id} "
                	__kobman_echo_no_colour "$version_id" > "$destdir"
			__kobman_install_"${environment_name}" "${environment_name}" "${version_id}" "${namespace_name}" 
			return 1	
		else
			__kobman_echo_white "Version  ${version_id} of https://github.com/${namespace_name}/${environment_name} already existing in your local system ! "
			cd ~
		fi
}
