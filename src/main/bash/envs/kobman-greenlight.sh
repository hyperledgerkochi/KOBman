#!/bin/bash

function __kobman_install_greenlight
{

	local environment_name="$1"
	local version_id="$2"
	cd ~

	if [ ! -d "Dev_greenlight" ]; then
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

    sudo ~/Dev_greenlight/greenlight/docker/manage build
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
  	sudo ~/Dev_greenlight/greenlight/docker/manage build
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	fi
	cd ~

}

function __kobman_start_greenlight
{
 	__kobman_echo_white "Deploying Greenlight environment from Github namespace : "
	__kobman_echo_green "${kobman_namespace}"
       	chmod a+rwx ${KOBMAN_GREENLIGHT_DEV_DIR}
	${KOBMAN_GREENLIGHT_DEV_DIR}/greenlight/docker/manage start
}

function __kobman_uninstall_greenlight
{
 	__kobman_echo_white "Removing Greenlight environment...  "
       	sudo chmod 777 ${KOBMAN_GREENLIGHT_DEV_DIR}
	cd ${KOBMAN_GREENLIGHT_DEV_DIR} rm 2> /dev/null
	greenlight/docker/manage rm 2> /dev/null
	rm -rf greenlight/ 2> /dev/null
	rm -rf greenlight/ /usr/local/bin/sti /usr/local/bin/s2i source-to-image-v1.1.14-874754de-linux-amd64.tar.gz 2> /dev/null
        cd ~
       	rm -rf ${KOBMAN_GREENLIGHT_DEV_DIR} 2> /dev/null
 	__kobman_echo_red "Greenlight environment removed !! "
        cd ~
}

function __kobman_version_greenlight
{
	if [ -d "${KOBMAN_GREENLIGHT_DEV_DIR}" ]; then
		kobman_namespace="$1"
		cd ${KOBMAN_GREENLIGHT_DEV_DIR}
		cd greenlight/
		git show-ref --tag | grep -o 0.0.*
		cd ~
	else
 		__kobman_echo_green "Greenlight is not installed ! "
	fi
}
