#!/bin/bash 


function __kobman_install_kobvon
{
	kobman_namespace="$1"
	__kobman_echo_red "Building KOBVON-(TheOrgBook) from"
	__kobman_echo_red " ${kobman_namespace}"
	cd $HOME
        git clone https://github.com/${kobman_namespace}/KOBVON
}

function __kobman_start_kobvon
{
	__kobman_echo_red "Starting KOBVON from ${kobman_namespace}"
	cd $HOME
}

function __kobman_uninstall_kobvon
{
 	__kobman_echo_red "KOBVON- Uninstalling ..."	
	cd ${KOBMAN_CANDIDATES_DIR}
}

#function __kobman_version_kobvon
#{
# 	__kobman_echo_red "VON-(KochiOrgBook) - Version 1 (to be worked)"
#}


