#!/usr/bin/env bash

function __kob_help {

	__kobman_echo_yellow "KOBman - Help"
	__kobman_echo_blue "------------------------------------------------------------"
	__kobman_echo_white " $ kob <command> <qualifer> <version> <namespace>"   
	__kobman_echo_white ""
	__kobman_echo_white "namespace"
	__kobman_echo_blue "-------------------------------------------------------------"
	__kobman_echo_white "A Namespace is a mechanism to partition resources created by"
	__kobman_echo_white "users into a logically named group."
	__kobman_echo_white ""
	__kobman_echo_white "bcgov  		: The namespace of the British Columbia"
	__kobman_echo_white "hyperledgerkochi: The namespace of Kochi"
	__kobman_echo_white ""
	__kobman_echo_white "Environment"
	__kobman_echo_blue "-------------------------------------------------------------"
	__kobman_echo_white ""
	__kobman_echo_white "tobvon     : https://github.com/hyperledgerkochi/von-network"
	__kobman_echo_white "tob        : https://github.com/hyperledgerkochi/TheOrgBook"
	__kobman_echo_white "greenlight : https://github.com/hyperledgerkochi/greenlight"
	__kobman_echo_white "kobman     : https://github.com/hyperlederkochi/KOBman"
	__kobman_echo_white ""
	__kobman_echo_white ""
	__kobman_echo_white "Commands"
	__kobman_echo_blue "-------------------------------------------------------------"
	__kobman_echo_white "install     : $ kob install <environment><version><namespace>"          
	__kobman_echo_white "              The command is used to install the specified "
	__kobman_echo_white "              environment."
	__kobman_echo_white "              Eg: $ kob install --dev tobvon bcgov"
	__kobman_echo_white ""
	__kobman_echo_white "uninstall   : $ kob uninstall <qualifier> <environment> <namespace>"
	__kobman_echo_white "              The command is used to uninstall the specified "
	__kobman_echo_white "              environment."
	__kobman_echo_white "              Eg: $ kob uninstall --dev tobvon bcgov"
	__kobman_echo_white ""
	__kobman_echo_white "status      : $ kob status"  
	__kobman_echo_white "              The command displays the installed environments."
	__kobman_echo_white ""
	__kobman_echo_white "list        : $ kob list"
	__kobman_echo_white "              The command lists the various environment that "
	__kobman_echo_white "              can be installed."
	__kobman_echo_white ""
	__kobman_echo_white "version     : $ kob version <environment>"
	__kobman_echo_white "              The command displays the version of the specified "
	__kobman_echo_white "              environment."
	__kobman_echo_white "              "
	__kobman_echo_white "              Eg: $ kob version tobvon"
	__kobman_echo_white ""
	__kobman_echo_white "help        : $ kob help"
    __kobman_echo_white "              Displays the KOBman manual"
	
}