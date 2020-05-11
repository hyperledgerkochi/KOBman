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
git branch -D $branch
git checkout -b $branch


#copy the tmpl file to /scripts and rename it
cp ~/KOBman/scripts/tmpl/*.tmpl ~/KOBman/scripts/
# mv ~/KOBman/scripts/*.tmpl *.tmpl//.tmpl/
# exit 0
for file in $KOB_DIR/scripts/*.tmpl;
do
    sed -i "s/@KOB_VERSION@/$kob_version/g" $file
    sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/$KOB_ARCHIVE_DOWNLOAD_REPO/g" $file
    sed -i "s/@KOB_NAMESPACE@/$KOB_NAMESPACE/g" $file
    mv "$file" "${file//.tmpl/}"
done

git add ~/KOBman/scripts/*.*
exit 0
git commit -m "Update version of $branch to $kob_version"

#push release branch
git push -f origin $branch

#Push tag 
git tag -a $kob_version -m "Releasing version $kob_version"
git push origin $kob_version


git checkout dev

