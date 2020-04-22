#!/bin/bash


function __kob_status {

__kobman_echo_cyan "=========STATUS========="
cd ${HOME} 
ls -d Dev_* 2> /dev/null

}
