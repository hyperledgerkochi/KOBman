#!/bin/bash

function __kob_version {


  local environment_parameter=$1
  local environment_value=$2

  if [ -z "$environment_parameter" ]
  then
    echo "KOBman version" "$(cat ${KOBMAN_DIR}/var/version.txt)"
    return 0
  fi

  if [[ ! -z $environment_value && -f "${KOBMAN_DIR}/envs/kob_env_${environment_value}/current" ]]
  then
                echo "${environment_value} version" "$(cat ${KOBMAN_DIR}/envs/kob_env_${environment_value}/current)"
  else
                __kobman_echo_red "$environment_value environment is not installed in the Local system !"
  fi

}
