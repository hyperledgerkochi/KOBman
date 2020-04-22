#!/bin/bash 
                                                              
function __kobman_development_tob_dir {

	cd ~	
	  mkdir -p Dev_TOB
	cd Dev_TOB
	export KOBMAN_TOB_DEV_DIR=$PWD
	  chmod 777 ${KOBMAN_TOB_DEV_DIR}
	cd ${KOBMAN_TOB_DEV_DIR}
	  mkdir -p test/ dependency/
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
	  git clone https://github.com/${kobman_namespace}/TheOrgBook.git
          wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
          tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
          mv s2i sti /usr/local/bin/
          TheOrgBook/docker/manage rm
          TheOrgBook/docker/manage build
          sed -i -e 's/- 3000/- 3100/g' TheOrgBook/docker/docker-compose.yml
	__kobman_echo_cyan "TOB Development Environment is installed."	
	cd ~
}

function __kobman_start_tob
{
	__kobman_echo_cyan "Starting TheOrgBook from "	
	__kobman_echo_cyan "${kobman_namespace}"	
#	  chmod a+rwx ${KOBMAN_TOB_DEV_DIR}
	cd ${KOBMAN_TOB_DEV_DIR}
	  TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000
}

function __kobman_uninstall_tob
{
 	__kobman_echo_cyan "TheOrgBook - Uninstalling..."	
#	  chmod a+rwx $KOBMAN_TOB_DEV_DIR
	cd ${KOBMAN_TOB_DEV_DIR}
	  TheOrgBook/docker/manage rm 2> /dev/null	
	  rm ${KOBMAN_TOB_DEV_DIR}/source-* 2> /dev/null	
	  rm -rf TheOrgBook/ 2> /dev/null 	
	  rm -rf /usr/local/bin/s2i /usr/local/bin/sti TheOrgBook/ 2> /dev/null	
	cd ~
	  rm -rf ${KOBMAN_TOB_DEV_DIR} 2> /dev/null
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
