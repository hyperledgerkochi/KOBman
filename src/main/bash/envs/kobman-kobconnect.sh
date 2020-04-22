#!/bin/bash


function __kobman_install_kobconnect
{

		kobman_namespace="$1"
		__kobman_echo_yellow "Building KOB-Connect from ${kobman_namespace}"
		cd $HOME	
		git clone https://github.com/${kobman_namespace}/KOBConnect.git
}

function __kobman_uninstall_kobconnect
{
	__kobman_echo_yellow "KochiOrgBook-Connect - Uninstalling..."
	cd $HOME	
	rm -rf KOBConnect/

}


function __kobman_version_kobconnect
{
	__kobman_echo_yellow "KochiOrgBook-Connect - Version 1 []"
}
