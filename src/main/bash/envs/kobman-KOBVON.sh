#!/bin/bash 


function __kobman_install_kobvon
{
	kobman_namespace="$1"
 	__kobman_echo_red "Building VON-(KochiOrgBook) from $(kobman_namespace)"
	cd ${KOBMAN_CANDIDATES_DIR}
        sudo git clone https://github.com/${kobman_namespace}/von-network.git
        sudo von-network/manage rm
        sudo von-network/manage build
}

function __kobman_start_kobvon
{
	__kobman_echo_red "Starting VON-(KochiOrgBook) from $(kobman_namespace)"
	cd ${KOBMAN_CANDIDATES_DIR}
        sudo von-network/manage start
}

function __kobman_uninstall_kobvon
{
 	__kobman_echo_red "VON-(KochiOrgBook) - Uninstalling ..."	
	cd ${KOBMAN_CANDIDATES_DIR}
        sudo von-network/manage start
	sudo von-network/manage rm
	sudo rm -rf von-network/
}

function __kobman_version_kobvon
{
 	__kobman_echo_red "VON-(KochiOrgBook) - Version 1 (to be worked)"
}
