#!/bin/bash

kob_version="$1"

branch="Release"

# sanityls
if [[ -z "$kob_version" ]]; 
    then
        echo "Usage: release.sh <version>"
 	    exit 0
fi

vars="$kob_version $KOB_ARCHIVE_DOWNLOAD_REPO $KOB_NAMESPACE"
cd ~/KOBman
git checkout dev
git checkout -b $branch
git checkout $branch

#copy the tmpl file to /scripts and rename it

cp $KOB_DIR/scripts/tmpl/* $KOB_DIR/scripts/
for file in $KOB_DIR/scripts/*.tmpl;
do
    for v in $vars;
    do
        sed -i "s/@v@/${v}/g" $file
    done
    mv "$file" "${file//.tmpl/}"
    
    

done


git add .
git commit -m "Update version of $branch to $kob_version"

#push release branch
git push -f origin $branch

#Push tag 
git tag -a "$kob_version" -m "Releasing version $kob_version"
git push origin $kob_version


git checkout dev

