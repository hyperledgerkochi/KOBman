#!/bin/bash

branch=Release
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
# git checkout tags/$kob_rel_version -b $kob_rel_version
git checkout $branch

mkdir -p ~/KOBman/dist

echo "making the tar files..."
tar -cvf ~/KOBman/dist/kobman-latest.tar ~/KOBman/src/ 
cp ~/KOBman/dist/kobman-latest.tar ~/KOBman/dist/kobman-$kob_rel_version.tar

# moving get.kobman.io to dist
mv ~/KOBman/scripts/get.kobman.io ~/KOBman/dist/

# moving into dist branch
git checkout dist

git checkout $branch -- ~/KOBman/dist/ &> /dev/null


echo "saving changes and pushing"
git add .
git commit -m "Released the version $kob_rel_version"
git push origin dist


git checkout dev





