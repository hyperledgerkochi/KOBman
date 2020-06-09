#!/bin/bash

#function __kobman_development_tobvon_dir 
#{
#	local namespace="$1"	
#	local version_id="$2"	
#	cd ~
#	if [ ! -d "${KOBMAN_VON_DEV_DIR}/von-network" ]; then 
#		
#		__kobman_install_dependancies
#		mkdir -p Dev_TOBVON
#		cd Dev_TOBVON
#		export KOBMAN_VON_DEV_DIR=$PWD
#		cd ${KOBMAN_VON_DEV_DIR}
#		mkdir -p test/ dependency/
#               	__kobman_echo_cyan "Copying source code  of https://github.com/${namespace}/von-network to your local system ! "
#	else
#		__kobman_install_dependancies
#		rm -rf  Dev_TOBVON
#		mkdir -p Dev_TOBVON
#		cd Dev_TOBVON
#		export KOBMAN_VON_DEV_DIR=$PWD
#		cd ${KOBMAN_VON_DEV_DIR}
#		mkdir -p test/ dependency/
#               	__kobman_echo_cyan "Removing existing older version & Copying newer Version : "${version_id}" ,  source code from https://github.com/${namespace}/KOBman into your local system ! "
#	
#	fi
#
#
#
#}                                                                                                                          
function __kobman_install_von-network
{

	local environment_name="$1"
	local version_id="$2"	

	cd ~	
	
	if [ ! -d "Dev_von-network" ]; then 
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		cd ~
		mkdir -p Dev_"${environment_name}"
		cd Dev_"${environment_name}"
#		export Dev_"${environment_name}" = $PWD

		mkdir -p test/ dependency/
		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null	
		__kobman_install_dependancies
        	# sudo ~/Dev_von-network/von-network/manage rm
        	sudo ~/Dev_von-network/von-network/manage build
		 __kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	else
 		__kobman_echo_white "Removing existing version "
		rm -rf ~/Dev_"${environment_name}"	
 		__kobman_echo_white "Creating Dev environment for ${environment_name}"
 		__kobman_echo_white "from https://github.com/${KOBMAN_NAMESPACE}/${environment_name}"
 		__kobman_echo_white "version :${version_id} "
		
		cd ~
		mkdir -p Dev_"${environment}"
		cd Dev_"${environment}"
		export Dev_von-network=$PWD
		mkdir -p test/ dependency/

		git clone https://github.com/${KOBMAN_NAMESPACE}/${environment_name} 2> /dev/null	
		__kobman_install_dependancies
        	sudo ~/Dev_von-network/von-network/manage rm
        	sudo ~/Dev_von-network/von-network/manage build
		__kobman_echo_violet "Dev environment for ${environment_name} created successfully"
	fi		
	cd ~




#__kobman_development_tobvon_dir "${kobman_namespace}" "${version_id}"
#
#	git clone https://github.com/${kobman_namespace}/von-network.git
#        von-network/manage rm
#        von-network/manage build
#	cd ~

}

function __kobman_start_tobvon
{

 	__kobman_echo_white "Deploying Verifiable Organizations Network environment from Github namespace : "	
	__kobman_echo_green "${kobman_namespace}"
        cd ${KOBMAN_VON_DEV_DIR} 
	von-network/manage start
}




#################newly incorporated code from kobma-dependancy.sh################



#function __kobman_create_dev_environment 
#{
#	local environment="$1"	
#	local version_id="$2"	
#	cd ~
#	mkdir -p Dev_"${environment}"
#	cd Dev_"${environment}"
#	export "${environment}"_DEV_DIR=$PWD
#	mkdir -p test/ dependency/
#}
	



function __kobman_install_dependancies {     

#	__kobman_check_proxy
  #      __kobman_ubuntu_update_upgrade
        __kobman_git_install
        __kobman_python_install
        __kobman_docker_install
        __kobman_npm_install
#        __kobman_visual_studio_install

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
	 	dpkg --configure -a
		__kobman_echo_red "By passing proxy server requires listed values\n"
		read -p "Enter the proxy?[eg: Kochin.dummy.com..etc] : " prox
        	echo -e "\n"
         	read -p "Enter the port?[eg :8980,443..etc]          : " port
         	echo -e "\n"
         	read -p "Enter proxy user name                       : " uname
         	echo -e "\n"
         	read  -p "Enter proxy password?[your login password] : " pword
         	__kobman_echo_red "Configure github username/email"
         	read -p "Enter github user name                      : " git_uname
         	echo -e "\n"
         	read -p "Enter github email ID?                      : " emil
         	echo -e "\n"
         	__kobman_proxy_environment
        for proto in http https ftp socks;
        do
                if [ "$proto" = "https" ];
                then
                  	printf 'Acquire::%s::proxy "http://%s:%s@%s:%u/";\n' "$proto" "$uname" "$pword" "$prox" "$port"
                else
                        printf 'Acquire::%s::proxy "%s://%s:%s@%s:%u/";\n' "$proto" "$proto" "$uname" "$pword" "$prox" "$port"
                fi

        done | sudo tee -a /etc/apt/apt.conf > /dev/null
        mkdir -p /etc/systemd/system/docker.service.d/
        touch /etc/systemd/system/docker.service.d/https-proxy.conf
        chmod 777 /etc/systemd/system/docker.service.d/https-proxy.conf
        echo -e "[Service]\nEnvironment="HTTPS_PROXY=http://${uname}:${pword}@${prox}:${port}"">>/etc/systemd/system/docker.service.d/https-proxy.conf

        echo "**********************"
        git config --global user.name "${git_uname}"
        git config --global user.email "${emil}"
	apt install ca-certificates -y
        git config --global http.sslVerify false
        git config --global http.proxy http://${uname}:${pword}@${prox}:${port}

else 
	echo "Skipping the proxy settings"
fi

}




function __kobman_git_install {

	__kobman_echo_yellow "Installing Git"
	sudo apt install git -y

}

function __kobman_python_install {
	
	__kobman_echo_yellow "Installing Python"
	sudo apt install software-properties-common -y
        sudo apt install Python -y
        #sudo apt install Python3.7 -y
        sudo apt install python-pip -y
	pip install --upgrade pip
	sudo ln -sfn /usr/bin/python3.7 /usr/bin/python
}

function __kobman_docker_install {

        sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io -y
	curl -fsSL https://get.docker.com -o get-docker.sh
    	sudo sh get-docker.sh 
	sudo usermod -aG docker $USER 

#        sudo apt-get remove docker docker-engine docker-ce docker-ce-cli docker.io -y
#	sudo apt-get update -y
#        apt install docker.io -y
#	      sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
#
#	__kobman_echo_yellow "Adding docker official key"
#	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#	__kobman_echo_yellow "Verifying apt key fingerprint"
#	sudo apt-key fingerprint 0EBFCD88
#
#	__kobman_echo_yellow "Setting up $(lsb_release -is) $(lsb_release -cs) docker-stable repository"
#        sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
#	__kobman_echo_yellow "Installing Docker-Engine"
#	sudo apt-get update -y
#        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
        sudo docker run hello-world
	__kobman_echo_yellow "Installing Docker-Compose"

	sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#	sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

        sudo chmod +x /usr/local/bin/docker-compose
        sudo systemctl start docker
        sudo systemctl enable docker
	__kobman_echo_yellow "Docker Version"
        sudo docker --version
	__kobman_echo_yellow "Docker-Compose Version"
        sudo docker-compose --version
	__kobman_echo_red "Docker Login"
#	sudo rm -rf /root/.docker/
#        >/etc/systemd/system/docker.service.d/https-proxy.conf > /dev/null
	sudo docker logout
	sudo docker login

#        if [[ "$proxychk" -eq 1 ]]
#        then
#		__kobman_echo_red "Docker proxy setting up @ /root/.docker/config.json"
#                sudo sed -i '$ d' /root/.docker/config.json
#                sudo echo -e ",\n "\""proxies"\"": {\n\t "\""default"\"": {\n\t\t "\""httpProxy"\"": "\""http://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""httpsProxy"\"": "\""https://${uname}:${pword}@${prox}:${port}"\"",\n\t\t "\""noProxy"\"": "\""localhost,127.0.0.0/8,*.local,host.docker.internal"\"" \n\t\t}\n\t}\n}">>/root/.docker/config.json
#
#	fi
}

function __kobman_npm_install {
	
	__kobman_echo_yellow "Purging existing NPM components"
	npm config rm proxy
        npm config rm proxy --global

        npm config rm https-proxy
        npm config rm https-proxy --global

        npm config rm registry
        npm cache clean

        sudo apt-get remove nodejs nodejs-dev node-gyp libssl1.0-dev npm -y
 
	__kobman_echo_yellow "Installing NPM"
        sudo apt-get install nodejs nodejs-dev node-gyp libssl1.0-dev npm -y

#        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}--global
#        npm config set https-proxy http://${uname}:${pword}@${prox}:${port}
#
#        npm config set proxy http://${uname}:${pword}@${prox}:${port}--global
#        npm config set proxy http://${uname}:${pword}@${prox}:${port}
#
#        npm config set registry http://registry.npmjs.org
        npm config set strict-ssl false


}


function __kobman_visual_studio_install {

	__kobman_echo_yellow "Installing Visual-Studio"	
	sudo apt install software-properties-common apt-transport-https wget
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install code

}






################################old codes to refer if required ################




#function __kobman_uninstall_tobvon
#{
# 	__kobman_echo_white "Removing Verifiable Organizations Network environment...  "	
#	cd ${KOBMAN_VON_DEV_DIR} 
#	rm -rf von-network/ 2> /dev/null	
#	cd ~
#	rm -rf Dev_TOBVon/ 2> /dev/null	
#	rm -rf ${KOBMAN_VON_DEV_DIR} 2> /dev/null	
# 	__kobman_echo_red "Verifiable Organizations Network environment removed !! "	
#	cd ~
#}
#
#function __kobman_version_tobvon
#{
#	if [ -d "${KOBMAN_TOBVON_DEV_DIR}" ]
#	then 
#		kobman_namespace="$1"
#		cd ${KOBMAN_VON_DEV_DIR} 
#		cd von-network/	
#		git show-ref --tag | grep -o v0.0.*
#		cd ~
#	else
# 		__kobman_echo_red " Verifiable Organizations Network environment is not installed in the Local system !"	
#	fi
#}
