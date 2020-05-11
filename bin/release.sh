#!/bin/bash

kob_version="$1"

branch="Release"

# sanityls
if [[ -z "$kob_version" ]]; 
    then
        echo "Usage: release.sh <version>"
 	    exit 0
fi

cd ~/KOBman
git checkout dev
git checkout -b $branch
git checkout $branch

#copy the tmpl file to /scripts and rename it

cp $KOB_DIR/scripts/tmpl/*.tmpl $KOB_DIR/scripts/
for file in $KOB_DIR/scripts/*.tmpl;
do
    sed -i "s/@KOB_VERSION@/"$KOB_VERSION"/g" $file
    sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/"$KOB_ARCHIVE_DOWNLOAD_REPO"/g" $file
    sed -i "s/@KOB_NAMESPACE@/"$KOB_NAMESPACE"/g" $file
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

