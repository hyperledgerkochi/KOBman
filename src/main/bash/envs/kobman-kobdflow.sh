#!/bin/bash 


function __kobman_install_kobdflow
{
		kobman_namespace="$1"
		__kobman_echo_green "Building KOBDflow from ${kobman_namespace}"
		git clone https://github.com/${kobman_namespace}/KOBDflow
		cd $HOME
}

function __kobman_start_kobdflow
{
	__kobman_echo_green "Starting KochiOrgBook-Dflow from $(kobman_namespace)"	
}

function __kobman_uninstall_kobdflow
{
	__kobman_echo_green "KochiOrgBook-Dflow - Uninstalling ... $(kobman_namespace)"	
}

#function __kobman_version_kobdflow
#{
#	__kobman_echo_green "KochiOrgBook-Dflow - Version [work to be done]"
#}

