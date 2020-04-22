#!/bin/bash 


function __kobman_install_kobregistery
{

		kobman_namespace="$1"		
		__kobman_echo_cyan "Building KOB-Registory from ${kobman_namespace}"	
		cd $HOME
		git clone https://github.com/${kobman_namespace}/KOBRegistry.git
}

function __kobman_uninstall_kobregistery
{
	__kobman_echo_cyan "KochiOrgBook-Registory - Uninstalling..."	
	cd $HOME
	sudo rm -rf KOBRegistry/
	cd $HOME

}

#function __kobman_version_kobregistery
#{
#	__kobman_echo_cyan "Building KochiOrgBook-Registory - Version -1"
#}


