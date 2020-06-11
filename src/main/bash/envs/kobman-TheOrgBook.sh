#!/bin/bash


function __kobman_install_TheOrgBook
{

	local environment_name="$1"
	local version_id="$2"

	cd ~

	if [ ! -d "Dev_TheOrgBook" ]; then
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		cd ~
		mkdir -p Dev_"${environment_name}"
		cd Dev_"${environment_name}"
		mkdir -p test/ dependency/
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null
		sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
 		sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
    sudo mv sti s2i /usr/local/bin/
  	sudo ~/Dev_TheOrgBook/TheOrgBook/docker/manage build
    __kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	else
 		__kobman_echo_white "Removing existing version "
		sudo rm -rf ~/Dev_"${environment_name}"
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "

		cd ~
		mkdir -p Dev_"${environment}"
		cd Dev_"${environment}"
		mkdir -p test/ dependency/
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null
		sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
 		sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
    sudo mv sti s2i /usr/local/bin/
  	sudo ~/Dev_TheOrgBook/TheOrgBook/docker/manage build
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	fi
	cd ~


}

function __kobman_start_tob
{
 	__kobman_echo_white "Deploying TheOrgBook environment from Github namespace : "
	__kobman_echo_green "${kobman_namespace}"

	${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/manage start seed=the_org_book_0000000000000000000

}

function __kobman_uninstall_tob
{
 	__kobman_echo_white "Removing TheOrgBook environment...  "
	chmod a+rwx $KOBMAN_TOB_DEV_DIR
	${KOBMAN_TOB_DEV_DIR}/TheOrgBook/docker/manage rm 2> /dev/null
	rm ${KOBMAN_TOB_DEV_DIR}/source-* 2> /dev/null
	rm -rf ${KOBMAN_TOB_DEV_DIR}/TheOrgBook/ 2> /dev/null
	rm -rf /usr/local/bin/s2i /usr/local/bin/sti TheOrgBook/ 2> /dev/null
	cd ~
	rm -rf ${KOBMAN_TOB_DEV_DIR} 2> /dev/null
 	__kobman_echo_red "TheOrgBook environment removed !! "
	cd ~
}

function __kobman_version_tob
{
	if [ ! -d "${KOBMAN_TOB_DEV_DIR}" ]; then
		kobman_namespace="$1"
		cd ${KOBMAN_TOB_DEV_DIR}
		cd TheOrgBook/
		git show-ref --tag | grep -o 0.0.*
		cd ~
	else
 		__kobman_echo_red "TheOrgBook Environment is not installed in the Local system !"
	fi
}
