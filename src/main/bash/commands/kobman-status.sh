#!/bin/bash


function __kob_status {

sudo rm ${KOBMAN_CANDIDATES_DIR}/*.tar.gz 2> /dev/null
sudo rm ${KOBMAN_CANDIDATES_DIR}/source-to-image-v1.1.14-874754de-linux-amd64.tar.gz.* 2> /dev/null
__kobman_echo_cyan "=========STATUS========="
cd ${KOBMAN_CANDIDATES_DIR} 
sudo ls -d Dev_* 2> /dev/null

}