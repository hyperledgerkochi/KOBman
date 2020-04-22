#!/usr/bin/env bash


function __kob_version {

 	local command deployment_type environment_type name_space 
	command=$COMMAND
	deployment_type=$DEPLOYMENT_TYPE
	environment_type=$ENVIRONMENT_TYPE
	name_space=$NAME_SPACE                                                                   
	if [ "$DEPLOYMENT_TYPE" == "" ] 
	then
		cd "${KOBMAN_DIR}/var"	
		cat version.txt	
		cd ~	
	else	
		__kobman_environment_version  
	fi
}



function __kobman_environment_version {

 	local name_space 
	name_space=$1
	if [ "$DEPLOYMENT_TYPE" == "--environment" ] 
	then	
	
		__kobman_version_${ENVIRONMENT_TYPE} 
#		case "$ENVIRONMENT_TYPE" in
#		tobvon)
#			__kobman_version_tobvon 
#
#		;;	
#		tob)
#			__kobman_version_tob 
#
#		;;	
#		greenlight)
#			__kobman_version_greenlight 
#		;;	
#		kobman)
#			__kobman_version_kobman 
#
#		;;	
#		kobvon)
#			echo "invoking kobman version"
#			__kobman_version_kobvon 
#
#		;;	
#		kob)
#			__kobman_version_kob 
#
#		;;	
#		kobdflow)
#			__kobman_version_kobdflow 
#
#		;;	
#		kobconnect)
#			__kobman_version_kobconnect 
#
#		;;	
#		kobregistery)
#			__kobman_version_kobregistery
#
#		;;
#		"")
#			echo "verify your command &  try again"	
#
#		;;	
#	esac
	fi
}
