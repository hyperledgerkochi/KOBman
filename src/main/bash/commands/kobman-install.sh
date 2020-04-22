#!/usr/bin/env bash


function __kob_install {

	local command deployment_type environment_type parameter_type name_space 

	command=$COMMAND
	deployment_type=$DEPLOYMENT_TYPE
	environment_type=$ENVIRONMENT_TYPE
	parameter_type=$PARAMETER_TYPE
	name_space=$NAME_SPACE 
	
	if [ "$command" = "install" ]
	then
        	case $deployment_type in
                --environment | -env)

				if [ "$parameter_type" = "--namespace" ]
                        	then
 					__kobman_install_${environment_type} "$name_space"
				else
					echo "Try with parameter '--namespace'"		
				fi

                *)
                        if [ -z $deployment_type ]
                        then
                                echo "Default Projects are tobvon,tob,greenlight"
                        fi
                ;;

       		 esac

	fi

}

function __kobman_install_dependancies {

	__kobman_check_proxy
        __kobman_ubuntu_update_upgrade
        __kobman_git_install
        __kobman_python_install
        __kobman_docker_install
        __kobman_npm_install
        __kobman_visual_studio_install

}
function __kobman_download {
	local candidate version archives_folder

	candidate="$1"
	version="$2"

	archives_folder="${KOBMAN_DIR}/archives"
	if [ ! -f "${archives_folder}/${candidate}-${version}.zip" ]; then

		local platform_parameter="$(echo $KOBMAN_PLATFORM | tr '[:upper:]' '[:lower:]')"
		local download_url="${KOBMAN_CANDIDATES_API}/broker/download/${candidate}/${version}/${platform_parameter}"
		local base_name="${candidate}-${version}"
		local zip_archive_target="${KOBMAN_DIR}/archives/${candidate}-${version}.zip"

		#pre-installation hook: implements function __kobman_pre_installation_hook
		local pre_installation_hook="${KOBMAN_DIR}/tmp/hook_pre_${candidate}_${version}.sh"
		__kobman_echo_debug "Get pre-installation hook: ${KOBMAN_CANDIDATES_API}/hooks/pre/${candidate}/${version}/${platform_parameter}"
		__kobman_secure_curl "${KOBMAN_CANDIDATES_API}/hooks/pre/${candidate}/${version}/${platform_parameter}" > "$pre_installation_hook"
		__kobman_echo_debug "Copy remote pre-installation hook: $pre_installation_hook"
		source "$pre_installation_hook"
		__kobman_pre_installation_hook || return 1
		__kobman_echo_debug "Completed pre-installation hook..."

		export local binary_input="${KOBMAN_DIR}/tmp/${base_name}.bin"
		export local zip_output="${KOBMAN_DIR}/tmp/$base_name.zip"

		echo ""
		echo "Downloading: ${candidate} ${version}"
		echo ""
		echo "In progress..."
		echo ""

		#download binary
		__kobman_secure_curl_download "${download_url}" --output "${binary_input}"
		__kobman_echo_debug "Downloaded binary to: ${binary_input}"

		#post-installation hook: implements function __kobman_post_installation_hook
		#responsible for taking `binary_input` and producing `zip_output`
		local post_installation_hook="${KOBMAN_DIR}/tmp/hook_post_${candidate}_${version}.sh"
		__kobman_echo_debug "Get post-installation hook: ${KOBMAN_CANDIDATES_API}/hooks/post/${candidate}/${version}/${platform_parameter}"
		__kobman_secure_curl "${KOBMAN_CANDIDATES_API}/hooks/post/${candidate}/${version}/${platform_parameter}" > "$post_installation_hook"
		__kobman_echo_debug "Copy remote pre-installation hook: $pre_installation_hook"
		source "$post_installation_hook"
		__kobman_post_installation_hook || return 1

		__kobman_echo_debug "Processed binary as: $zip_output"

		__kobman_echo_debug "Completed post-installation hook..."

		mv "$zip_output" "$zip_archive_target"
		__kobman_echo_debug "Moved to archive folder: $zip_archive_target"
	else
		echo ""
		echo "Found a previously downloaded ${candidate} ${version} archive. Not downloading it again..."
	fi
	__kobman_validate_zip "${archives_folder}/${candidate}-${version}.zip" || return 1
	echo ""
}

function __kobman_validate_zip {
	local zip_archive zip_ok

	zip_archive="$1"
	zip_ok=$(unzip -t "$zip_archive" | grep 'No errors detected in compressed data')
	if [ -z "$zip_ok" ]; then
		rm "$zip_archive"
		echo ""
		__kobman_echo_red "Stop! The archive was corrupt and has been removed! Please try installing again."
		return 1
	fi

}



function __kobman_vim_fix {
	
	__kobman_echo_yellow "Configuring VIM" 
	sudo cd
        sudo echo "set nocompatible" > /root/.vimrc

}

function __kobman_ubuntu_update_upgrade {
	__kobman_echo_yellow "Upgrading/Updating Ubuntu"
	sudo apt-get update -y
        sudo apt-get dist-upgrade -y
	sudo apt-get -y install build-essential nghttp2 libnghttp2-dev libssl-dev -y
}

function __kobman_proxy_environment {
	__kobman_echo_yellow "Unsetting Proxy"
	unset http_proxy
        unset ftp_proxy
        unset https_proxy
        unset socks_proxy
        unset SOCKS_PROXY
        unset FTP_PROXY
        unset HTTPS_PROXY
        unset HTTP_PROXY
        export HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export HTTP_PROXY=http://${uname}:${pword}@${prox}:${port}/
        export FTP_PROXY=ftp://${uname}:${pword}@${prox}:${port}/
        export SOCKS_PROXY=socks://${uname}:${pword}@${prox}:${port}/

        export http_proxy=http://${uname}:${pword}@${prox}:${port}/
        export https_proxy=http://${uname}:${pword}@${prox}:${port}/
        export ftp_proxy=ftp://${uname}:${pword}@${prox}:${port}/
        export socks_proxy=socks://${uname}:${pword}@${prox}:${port}/
        env | grep -i proxy


}

function __kobman_check_proxy {

	__kobman_echo_red "================================="
	read -p "Behind Proxy ?! [y/n]" reply 
	__kobman_echo_red "================================="
        if [ "$reply" = "y" ] || [ "$reply" = "Y" ] || [ "$reply" = "yes" ] || [ "$reply" = "YES" ] 
	then
		proxychk=1
		sudo dpkg --configure -a
		__kobman_echo_red "By passing proxy server requires listed values\n"
		read -p "Enter the proxy?[eg: Kochin.dummy.com..etc] : " prox
        	sudo echo -e "\n"
         	read -p "Enter the port?[eg :8980,443..etc]          : " port
         	sudo echo -e "\n"
         	read -p "Enter proxy user name                       : " uname
         	sudo echo -e "\n"
         	read  -p "Enter proxy password?[your login password] : " pword
         	__kobman_echo_red "Configure github username/email"
         	read -p "Enter github user name                      : " git_uname
         	sudo echo -e "\n"
         	read -p "Enter github email ID?                      : " emil
         	sudo echo -e "\n"
         	__kobman_proxy_environment
        for proto in http https ftp socks;
        do
                if [ "$proto" = "https" ];
                then
                  	sudo printf 'Acquire::%s::proxy "http://%s:%s@%s:%u/";\n' "$proto" "$uname" "$pword" "$prox" "$port"
                else
                        sudo printf 'Acquire::%s::proxy "%s://%s:%s@%s:%u/";\n' "$proto" "$proto" "$uname" "$pword" "$prox" "$port"
                fi

        done | sudo tee -a /etc/apt/apt.conf > /dev/null
        sudo mkdir -p /etc/systemd/system/docker.service.d/
        sudo touch /etc/systemd/system/docker.service.d/https-proxy.conf
        sudo chmod 777 /etc/systemd/system/docker.service.d/https-proxy.conf
        sudo echo -e "[Service]\nEnvironment="HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}"">>/etc/systemd/system/docker.service.d/https-proxy.conf

        sudo echo "**********************"
        sudo git config --global user.name "${git_uname}"
        sudo git config --global user.email "${emil}"
	sudo apt install ca-certificates -y
        sudo git config --global http.sslVerify false
        sudo git config --global http.proxy http://${uname}:${pword}@${prox}:${port}

else 
       sudo echo "Skipping the proxy settings"
fi

}




function __kobman_git_install {

__kobman_echo_yellow "Installing Git"
sudo apt install git -y

}

function __kobman_python_install {
	
	__kobman_echo_yellow "Installing Python"
	sudo apt install software-properties-common -y
        sudo apt install Python3.7 -y
        sudo apt install python-pip -y
	pip install --upgrade pip
	sudo ln -sfn /usr/bin/python3.7 /usr/bin/python
}

function __kobman_docker_install {

          sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io -y
	__kobman_echo_yellow "Installing Docker"	
	sudo apt-get update -y
        sudo apt install docker.io -y
	__kobman_echo_yellow "Package permission : Allowing apt to use repository over HTTPS"

        sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

	__kobman_echo_yellow "Adding docker official key"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	__kobman_echo_yellow "Verifying apt key fingerprint"
	sudo apt-key fingerprint 0EBFCD88

	__kobman_echo_yellow "Setting up $(lsb_release -is) $(lsb_release -cs) docker-stable repository"
        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
	__kobman_echo_yellow "Installing Docker-Engine"
	sudo apt-get update -y
        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
        sudo docker run hello-world
	__kobman_echo_yellow "Installing Docker-Compose"
	sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        sudo chmod +x /usr/local/bin/docker-compose
        sudo systemctl start docker
        sudo systemctl enable docker
	__kobman_echo_yellow "Docker Version"
        sudo docker --version
	__kobman_echo_yellow "Docker-Compose Version"
        sudo docker-compose --version
	__kobman_echo_red "Docker Login"
	sudo rm -rf /root/.docker/
        >/etc/systemd/system/docker.service.d/https-proxy.conf > /dev/null
	sudo docker login

        if [[ "$proxychk" -eq 1 ]]
        then
		__kobman_echo_red "Docker proxy setting up @ /root/.docker/config.json"
                sudo sed -i '$ d' /root/.docker/config.json
                sudo echo -e ",\n "\""proxies"\"": {\n\t "\""default"\"": {\n\t\t "\""httpProxy"\"": "\""http://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""httpsProxy"\"": "\""https://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""noProxy"\"": "\""localhost,127.0.0.0/8,*.local,host.docker.internal"\"" \n\t\t}\n\t}\n}">>/root/.docker/config.json

	fi
}

function __kobman_npm_install {
	
	__kobman_echo_yellow "Purging existing NPM components"
	npm config rm proxy
        npm config rm proxy --global

        npm config rm https-proxy
        npm config rm https-proxy --global

        npm config rm registry
        npm cache clean

        sudo sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm -y
 
	__kobman_echo_yellow "Installing NPM"
        sudo sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm -y

        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}--global
        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}

        npm config set proxy http://${uname}:${pword}@${prox}:${port}--global
        npm config set proxy http://${uname}:${pword}@${prox}:${port}

        npm config set registry http://registry.npmjs.org
        npm config set strict-ssl false


}


function __kobman_visual_studio_install {

	__kobman_echo_yellow "Installing Visual-Studio"	
	sudo apt install software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install code

}
