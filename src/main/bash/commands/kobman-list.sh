#!/bin/bash

function __kob_list {

curl -L "${KOBMAN_SERVICE}/${KOBMAN_NAMESPACE}/KOBman/master/dist/list" | less

}
