#!/bin/bash

function __kob_list {

curl -L "${KOBMAN_SERVICE}/${KOBMAN_NAMESPACE}/KOBman/${KOBMAN_DIST_BRANCH}/dist/list" | less

}
