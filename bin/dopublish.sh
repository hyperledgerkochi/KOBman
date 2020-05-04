#!/bin/bash

kob_rel_version=$1
#kob_archive_download_repo="KOBman_target_repo"
kob_rel_stage_area=~/tmp
#kob_namespace="asa1997"

source $HOME/$USR/KOBman/bin/release_var_setup.sh

#Checkout latest tag
git checkout tags/$kob_rel_version -b $kob_rel_version

echo "making the tar files..."
tar -cvf $KOBMAN_DIR/bin/kobman-latest.tar $KOBMAN_DIR/src/ $KOBMAN_DIR/bin/
cp $KOBMAN_DIR/bin/kobman-latest.tar $KOBMAN_DIR/bin/kobman-$kob_rel_version.tar


mkdir $kob_rel_stage_area
cd $kob_rel_stage_area
git clone $LINK_TO_DOWNLOAD_REPO 
mkdir $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO/dist

#Moving necessary files to the target repo
mv $KOBMAN_DIR/bin/kobman*.tar $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO/dist
mv $KOBMAN_DIR/scripts/get.kobman.io $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO/dist
mv $KOBMAN_DIR/scripts/README.md $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO/dist


cd $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO/
git pull 
echo "saving changes and pushing"
sudo git add .
sudo git commit -m "Released the version $kob_rel_version"
git push origin master -f

cd $KOBMAN_DIR
sudo rm -rf $kob_rel_stage_area/$KOB_ARCHIVE_DOWNLOAD_REPO $kob_rel_stage_area

git checkout master
git merge $kob_rel_version
git branch -D $kob_rel_version


