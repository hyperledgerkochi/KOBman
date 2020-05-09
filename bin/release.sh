#!/bin/bash

kob_version="$1"

branch="Release"

# sanityls
if [[ -z "$kob_version" ]]; 
    then
        echo "Usage: release.sh <version>"
 	    exit 0
fi

if [ -z "$KOB_NAMESPACE" ];
    then
        KOB_NAMESPACE=${KOB_NAMESPACE:-hyperledgerkochi}

fi
echo $KOB_NAMESPACE
if [ -z "$KOB_ARCHIVE_DOWNLOAD_REPO" ];
    then
        KOB_ARCHIVE_DOWNLOAD_REPO=${KOB_ARCHIVE_DOWNLOAD_REPO:-KOBman_target_repo}
fi
echo $KOB_ARCHIVE_DOWNLOAD_REPO
if  [ -z "$KOB_DIR" ];
    then
        KOB_DIR=~/KOBman
fi
echo $KOB_DIR

variables = "$kob_version $KOB_ARCHIVE_DOWNLOAD_REPO $KOB_NAMESPACE"

git checkout dev
git checkout -b $branch
git checkout $branch

#copy the tmpl file to /scripts and rename it
cd KOB_DIR
cp $KOB_DIR/scripts/tmpl/* $KOB_DIR/scripts/
echo "a"
for file in $KOB_DIR/scripts/*.tmpl;
do
    echo "b"
    for v in $variables;
    do
        echo "c"
        sed -i "s/@v@/$v/g" $file
    done
    echo "d"
    mv "$file" "${file//.tmpl/}" 
done

exit 0

git add .
git commit -m "Update version of $branch to $kob_version"

#push release branch
git push -f origin $branch

#Push tag 
git tag -a "$kob_version" -m "Releasing version $kob_version"
git push origin $kob_version


git checkout dev

