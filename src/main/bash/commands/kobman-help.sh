#!/usr/bin/env bash

function __kob_help {
	__kobman_echo_white "KOBman - Help \n---------------------------------------------------------"
	__kobman_echo_white "$ kob <command> <qualifer> \n"
	__kobman_echo_white "<qualifier>   : environment, version, namespace\n"
	__kobman_echo_white "<command> \n ----------------------------------------------------------"
	__kobman_echo_white "install       : $ kob install –env [env_name] -V [version]\n\t\tThe command is used to install the specified\n\t\tenvironment.\n\t\tEg: $ kob install -env von-network –V 0.0.2\n"
	__kobman_echo_white "uninstall     : $ kob uninstall --environment [env_name]\n\t\tor\n\t\t$ kob uninstall –env [env_name] -V [version]\n\t\tThe command is used to uninstall the specified\n\t\tenvironment.\n\t\tEg: $ kob uninstall –env KOBman\n"
	__kobman_echo_white "status        : $ kob status\n\t\tThe command displays the installed environments.\n"
	__kobman_echo_white "list          : $ kob list\n\t\tThe command lists the various environment that\n\t\tcan be installed.\n"
	__kobman_echo_white "upgrade       : $ kob upgrade\n\t\tUpgrades KOBman to next version available.\n"
	__kobman_echo_white "update        : $ kob update\n\t\tUpdates the list file with lastest changes.\n"
	__kobman_echo_white "version       : Version of KOBman Utility\n\t\t-------------------------\n\t\t$ kob --version or kob –V\n\t\tThis command displays the version of KOBman\n\t\tinstalled on the host."
	__kobman_echo_white "\n\t\tVersion of an Environment\n\t\t-------------------------\n\t\t$ kob -V -env [env_name]\n\t\tThe command displays the version of the specified\n\t\tenvironment.\n\t\tEg: $ kob -V -env greenlight\n"
	__kobman_echo_white "help          : $ kob help\n\t\tDisplays the KOBman manual"
	}
