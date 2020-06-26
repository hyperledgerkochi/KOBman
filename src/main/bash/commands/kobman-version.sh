#!/usr/bin/env bash


function __kob_version {

  local environment_parameter=$1
  local environment_value=$2

  if [ -z "$environment_parameter" ]
	then
		echo "KOBman version" "$(cat ${KOBMAN_DIR}/var/version.txt)"
	else
		__kobman_version_"$environment_value"
	fi
}
