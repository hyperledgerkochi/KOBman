#!/bin/bash


function __kobman_install_kob
{

		
	kobman_namespace="$1"
 	__kobman_echo_cyan "Building KOB from ${kobman_namespace}"
	cd $HOME
	git clone https://github.com/${kobman_namespace}/KochiOrgBook

}

function __kobman_start_kob
{
	__kobman_echo_cyan "Starting KochiOrgBook from ${kobman_namespace}"	
	cd $HOME
}

function __kobman_uninstall_kob
{
	
	__kobman_echo_cyan "KochiOrgBook - Uninstalling ..."	
	cd $HOME


}

#function __kobman_version_kob
#{
#	__kobman_echo_cyan "KochiOrgBook - Version [need to worked on]"
#}
