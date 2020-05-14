#!/bin/bash

kob_rel_version=$1


if [ -z "$KOB_ARCHIVE_DOWNLOAD_REPO" ];
    then
        KOB_ARCHIVE_DOWNLOAD_REPO=${KOB_ARCHIVE_DOWNLOAD_REPO:-KOBman}
fi
# echo $KOB_ARCHIVE_DOWNLOAD_REPO

if [ -z "$KOB_NAMESPACE" ];
    then
        KOB_NAMESPACE=${KOB_NAMESPACE:-hyperledgerkochi}

fi

# echo $KOB_NAMESPACE

#Checkout latest tag
git checkout tags/$kob_rel_version -b $kob_rel_version


mkdir -p ~/KOBman/tmp/dist

echo "making the tar files..."
tar -cvf ~/KOBman/tmp/dist/kobman-latest.tar ~/KOBman/src/ 
cp ~/KOBman/tmp/dist/kobman-latest.tar kobman-$kob_rel_version.tar

git checkout dist

git checkout $kob_rel_version -- ~/KOBman/dist/
#Moving necessary files to the target repo
# mv ~/KOBman/scripts/get.kobman.io ~/KOBman/tmp/$KOB_ARCHIVE_DOWNLOAD_REPO/dist
# mv ~/KOBman/scripts/README.md ~/KOBman/tmp/$KOB_ARCHIVE_DOWNLOAD_REPO/dist


echo "saving changes and pushing"
git add .
git commit -m "Released the version $kob_rel_version"
git push origin dist


git checkout dev

git branch -D $kob_rel_version



