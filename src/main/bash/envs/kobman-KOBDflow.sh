#!/bin/bash 


function __kobman_install_kobdflow
{
		kobman_namespace="$1"
		__kobman_echo_green "Building KochiOrgBook-Dflow from $(kobman_namespace)"
		cd ${KOBMAN_CANDIDATES_DIR}
		sudo git clone https://github.com/${kobman_namespace}/greenlight.git
                sudo wget --no-proxy https://github.com/openshift/source-to-image/releases/download/v1.1.14/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo tar -xvzf source-to-image-v1.1.14-874754de-linux-amd64.tar.gz
                sudo mv s2i sti /usr/local/bin/
                sudo greenlight/docker/manage rm
                sudo greenlight/docker/manage build

}

function __kobman_start_kobdflow
{

	__kobman_echo_green "Starting KochiOrgBook-Dflow from $(kobman_namespace)"	
	if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ];
        then
		cd ${KOBMAN_CANDIDATES_DIR}
		sudo greenlight/docker/manage start
        fi
}

function __kobman_uninstall_kobdflow
{
	__kobman_echo_green "KochiOrgBook-Dflow - Uninstalling ... $(kobman_namespace)"	
	cd ${KOBMAN_CANDIDATES_DIR}
	sudo greenlight/docker/manage rm	
	sudo rm -rf greenlight/ /usr/local/bin/s2i /usr/local/bin/sti source-to-image-v1.1.14-874754de-linux-amd64.tar.gz 


}

function __kobman_version_kobdflow
{
	__kobman_echo_green "KochiOrgBook-Dflow - Version [work to be done]"
}

