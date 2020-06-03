#!/bin/bash 
                                                              
function __kobman_development_tob_dir {

	local namespace="$1"	
	local version_id="$2"	
	cd ~
	if [ ! -d "${KOBMAN_TOB_DEV_DIR}/von-network" ]; then 
		__kobman_install_dependancies
		mkdir -p Dev_TOB
		cd Dev_TOB
		export KOBMAN_TOB_DEV_DIR=$PWD
		cd ${KOBMAN_TOB_DEV_DIR}
		mkdir -p test/ dependency/
               	__kobman_echo_cyan "Copying source code  of https://github.com/${namespace}/KOBman to your local system ! "
	else
		rm -rf  Dev_TOB
		__kobman_install_dependancies
		mkdir -p Dev_TOB
		cd Dev_TOB
		export KOBMAN_TOB_DEV_DIR=$PWD
		cd ${KOBMAN_TOB_DEV_DIR}
		mkdir -p test/ dependency/
               	__kobman_echo_cyan "Removing existing older version & Copying newer Version : "${version_id}" ,  source code from https://github.com/${namespace}/KOBman into your local system ! "
	
	fi


}
function __kobman_install_TheOrgBook
{
	local kobman_namespace="$1"
	local version_id="$2"	
       	cd ~ 
       	__kobman_development_tob_dir "${kobman_namespace}" "${version_id}"

	git clone https://github.com/${kobman_namespace}/TheOrgBook.git
        wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
        mv sti s2i /usr/local/bin/
        ${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/manage rm 
	${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/manage build
        sed -i -e 's/- 3000/- 3100/g' ${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/docker-compose.yml
	cd ~
}

function __kobman_start_tob
{
 	__kobman_echo_white "Deploying TheOrgBook environment from Github namespace : "	
	__kobman_echo_green "${kobman_namespace}"
	${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000

}

