#!/usr/bin/env bash



function kob {

	command=$1
	qualifier1=$2 		# --environment
	qualifier2=$3 		# environment value
	qualifier3=$4 		# --version
	qualifier4=$5 		# version value

	case "$command" in
		-L)
			command="list";;
		-H)
			command="help";;
		-V | --version)
			command="version";;
		-I)
			command="install";;
		-U)
			command="uninstall";;
		-S)
			command="status";;
		-D)
			command="deploy";;
		-U | self-update)
			command="upgrade";;
		-u)
			command="update";;
	esac

	if [ -f "${KOBMAN_DIR}/etc/config" ]; then
		source "${KOBMAN_DIR}/etc/config"
	fi

	# no command provided
	if [[ -z "$command" ]]; then
		__kob_help
		return 1
	fi

	# Check if it is a valid command
	cmd_found=""
	cmd_target="${KOBMAN_DIR}/src/kobman-${command}.sh"
	if [[ -f "$cmd_target" ]]; then
		cmd_found="$cmd_target"
	fi

	# Check if it is a sourced function
	cmd_target="${KOBMAN_DIR}/envs/kobman-${command}.sh"
	if [[ -f "$cmd_target" ]]; then
		cmd_found="$cmd_target"
	fi
	# couldn't find the command
	if [[ -z "$cmd_found" ]]; then
		echo "Invalid command: $command"
		__kob_help
	fi



	# Check whether the command exists as an internal function...
	#
	# NOTE Internal commands use underscores rather than hyphens,
	# hence the name conversion as the first step here.
	converted_cmd_name=$(echo "$command" | tr '-' '_')

	# Store the return code of the requested command
	local final_rc=0

	# Execute the requested command
	if [ -n "$cmd_found" ]; then
		# It's available as a shell function
		if [ "$converted_cmd_name" = "install" ]; then
			__kobman_identify_parameter
		else
			__kob_"$converted_cmd_name" "$2" "$3" "$4"
			final_rc=$?
		fi
	fi

}

function __kobman_identify_parameter

{

	if [ -z "${qualifier1}" ]; then

		__kobman_echo_red "Invalid command : Try with --environment/-env "
		return 1
	fi

	if [ "${qualifier1}" == "--environment" ] || [ "${qualifier1}" == "-env" ]; then

		__kobman_validate_environment "${qualifier2}" || return 1
	fi

	if [ "${qualifier3}" == "--version" ]; then

		__kobman_validate_version_format "${qualifier4}" || return 1
		__kobman_check_if_version_exists "${qualifier2}" "${qualifier4}" || return 1
	fi


	if [ -z "${qualifier3}" ]; then
		__kobman_validate_version_format "$KOBMAN_VERSION" || return 1
		__kobman_check_if_version_exists "${qualifier2}" "$KOBMAN_VERSION" || return 1
	fi

	__kob_"$converted_cmd_name" "${qualifier2}" "${qualifier4}"
	 

}
