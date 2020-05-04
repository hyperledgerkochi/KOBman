#!/bin/bash

kob_version="$1"

branch="release"

#kob_archive_download_repo="KOBman_target_repo"
# kob_namespace=${KOBMAN_NAMESPACE:-hyperledgerkochi}

source $HOME/$USR/KOBman/bin/release_var_setup.sh

#sanityls
# if [[ -z "$kob_version" ]]; 
#     then
#         echo "Usage: release.sh <version>"
#  	    exit 0
# fi


git checkout master

#copy the tmpl file to /scripts and rename it
cp $KOBMAN_DIR/scripts/tmpl/get.kobman.io.tmpl $KOBMAN_DIR/scripts/
mv $KOBMAN_DIR/scripts/get.kobman.io.tmpl $KOBMAN_DIR/scripts/get.kobman.io
cp $KOBMAN_DIR/scripts/tmpl/README.md.tmpl $KOBMAN_DIR/scripts/
mv $KOBMAN_DIR/scripts/README.md.tmpl $KOBMAN_DIR/scripts/README.md
#replacing variables with actual values
sed -i "s/@KOB_VERSION@/$kob_version/g" $KOBMAN_DIR/scripts/get.kobman.io
sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/$KOB_ARCHIVE_DOWNLOAD_REPO/g" $KOBMAN_DIR/scripts/get.kobman.io
sed -i "s/@KOB_NAMESPACE@/$KOB_NAMESPACE/g" $KOBMAN_DIR/scripts/get.kobman.io
sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/$KOB_ARCHIVE_DOWNLOAD_REPO/g" $KOBMAN_DIR/scripts/README.md
sed -i "s/@KOB_NAMESPACE@/$KOB_NAMESPACE/g" $KOBMAN_DIR/scripts/README.md

sudo git add .
sudo git commit -m "Variables replaced with originals"

#Tagging and pushing 
sudo git tag -a "$kob_version" -m "Releasing version $kob_version"
git push origin $kob_version

git checkout -b $branch
git checkout $branch
git merge master


