#!/bin/bash 
                                                              
function __kobman_development_tob_dir {

	cd ~	
	sudo mkdir -p Dev_TOB
	cd Dev_TOB
	export KOBMAN_TOB_DEV_DIR=$PWD
	sudo chmod 777 ${KOBMAN_TOB_DEV_DIR}
	cd ${KOBMAN_TOB_DEV_DIR}
	sudo mkdir -p test/ dependency/
	if [ ! -d "${KOBMAN_VON_DEV_DIR}/von-network" ]
	then
		__kobman_install_dependancies
        fi
}
function __kobman_install_tob
{
        kobman_namespace="$1"
        __kobman_echo_cyan "Building TheOrgBook from"
        __kobman_echo_cyan "${kobman_namespace}"
	cd ${KOBMAN_CANDIDATES_DIR}
       	__kobman_development_tob_dir 
	sudo git clone https://github.com/${kobman_namespace}/TheOrgBook.git
        sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        sudo mv s2i sti /usr/local/bin/
        sudo TheOrgBook/docker/manage rm
        sudo TheOrgBook/docker/manage build
        sudo sed -i -e 's/- 3000/- 3100/g' TheOrgBook/docker/docker-compose.yml
	__kobman_echo_cyan "TOB Development Environment is installed."	
	cd ~
}

function __kobman_start_tob
{
	__kobman_echo_cyan "Starting TheOrgBook from "	
	__kobman_echo_cyan "${kobman_namespace}"	
#	sudo chmod a+rwx ${KOBMAN_TOB_DEV_DIR}
	cd ${KOBMAN_TOB_DEV_DIR}
	sudo TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
}

function __kobman_uninstall_tob
{
 	__kobman_echo_cyan "TheOrgBook - Uninstalling..."	
#	sudo chmod a+rwx $KOBMAN_TOB_DEV_DIR
	cd ${KOBMAN_TOB_DEV_DIR}
	sudo TheOrgBook/docker/manage rm 2> /dev/null	
	sudo rm ${KOBMAN_TOB_DEV_DIR}/source-* 2> /dev/null	
	sudo rm -rf TheOrgBook/ 2> /dev/null 	
	sudo rm -rf /usr/local/bin/s2i /usr/local/bin/sti TheOrgBook/ 2> /dev/null	
	cd ~
	sudo rm -rf ${KOBMAN_TOB_DEV_DIR} 2> /dev/null
	__kobman_echo_cyan "TOB Development Environment is un-installed."	
	cd ~
}	

function __kobman_version_tob
{
	if [ ! -d "${KOBMAN_TOB_DEV_DIR}" ]; then 
		kobman_namespace="$1"
		cd ${KOBMAN_TOB_DEV_DIR} 
		cd TheOrgBook/	
		git show-ref --tag | grep -o v0.0.*
		cd ~
	else
 		__kobman_echo_cyan "TOB is not installed"	
	fi
}
