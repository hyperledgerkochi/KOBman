#!/usr/bin/env bash

function __kob_install {

	environment_value=$1
 	version_value=$2
	namespace_value=$3 

	__kobman_create_environment_directory "$environment_value" "$version_value" "$namespace_value" 

}

function __kobman_validate_set_environment
{
	curl -sL "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/list" | grep -i "$1" > /dev/null
}

function __kobman_setting_global_variables
{
	environment_value=$1
        version_value=$2
     	namespace_value=$3
}

function __kobman_validate_and_set_version
{
	enviroment=$1
	version=$2
	namespace=$3	
	__kobman_validate_version_format "${version}" 
	if [ "$?" -eq "0" ];
	then
        	__kobman_check_and_confirm_existing_version "${enviroment}" "${version}" "${namespace}"  	# should introduce case for mapping kobman->KOBman,tob->TheOrgBook,von->von-network 
        	if [ "$?" -eq "0" ];   									 # check version.txt is empty or not (or version variable is empty or not)
        	then
                	version_value=$1
        		return 0	
		else
                	__kobman_echo_white "Inside ->  https://github.com/${namespace}/${environment}"
                	__kobman_echo_red "Version : ${version} is not available "
			return 1 
		fi
	else
        	__kobman_echo_red "Version format you have entered is incorrect"
        	__kobman_echo_green "Correct format -> 0.0.0 [eg: 0.0.2]"
		return 2  
	fi
	

}

function __kobman_validate_version_format
{
	__kobman_echo_no_colour "$1" | grep -w '[0-9]*\.[0-9]*\.[0-9]*' > /dev/null

}

function __kobman_check_and_confirm_existing_version
{
	env=$1
	version=$2
	namespace=$3	
      	case "$env" in 
		tob)
			confirmed_environment="TheOrgBook"		
		;;
		tobvon)
			confirmed_environment="von-network"		
		;;
		greenlight)
			confirmed_environment="greenlight"		
		;;
		KOBman)
			confirmed_environment="KOBman"		
		;;
	esac	

	git ls-remote --tags "https://github.com/${namespace}/${confirmed_environment}" | grep -w 'refs/tags/[0-9]*\.[0-9]*\.[0-9]*' | sort -r | head | grep -o '[^\/]*$' | grep -w "${version}" > /dev/null
							# version check is happening only for KOBman , need to create case statement for mapping kobman environemnts 
}

function __kobman_create_environment_directory
{

		environment_name=$1
		version_id=$2 
        	namespace_name=$3
		
		__kobman_echo_blue "Installing :"  
               	__kobman_echo_white "Repo/Namespace	: https://github.com/${namespace_name}/${environment_name}" 
               	__kobman_echo_white "Version		: ${version_id}" 
		
		cd "${KOBMAN_DIR}/envs"
                mkdir -p kob_env_"${environment_name}"
                cd kob_env_"${environment_name}"
                touch current
		destdir="${KOBMAN_DIR}/envs/kob_env_${environment_name}/current"
                if [ -f "$destdir" ]
                then
                	__kobman_echo_no_colour "$version_id" > "$destdir"
                fi
                mkdir -p $version_id
                cd $version_id                                          # Needs to be refactored identify the latest version 

      		cp "${KOBMAN_DIR}/envs/kobman-${environment_name}.sh" .
                source "${KOBMAN_DIR}/envs/kob_env_${environment_name}/${version_id}/kobman-${environment_name}.sh"
	#	__kobman_install_"${environment_name}" "${namespace_name}"

		__kobman_echo_blue "Installed from ->  https://github.com/${namespace_name}/${environment_name}"	
		cd ~
}
