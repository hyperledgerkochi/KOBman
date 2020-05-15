#!/bin/bash

kob_version="$1"

branch="Release"

# # sanity check
# if [[ -z "$kob_version" ]]; 
#     then
#         echo "Usage: release.sh <version>"
#         exit 0
# fi

#setting up environment variables
if [[ -z $KOB_ARCHIVE_DOWNLOAD_REPO ]];
    then
        KOB_ARCHIVE_DOWNLOAD_REPO={KOB_ARCHIVE_DOWNLOAD_REPO:-KOBman}
fi

if [[ -z $KOB_NAMESPACE ]];
    then
        KOB_NAMESPACE={KOB_NAMESPACE:-hyperledgerkochi}
fi

# prepare branch
cd ~/KOBman
git checkout dev
git branch -D $branch
git checkout -b $branch


#copy the tmpl file to /scripts 
cp ~/KOBman/scripts/tmpl/*.tmpl ~/KOBman/scripts/
# replacing @xxx@ variables with acutal values. 
for file in ~/KOBman/scripts/*.tmpl;
do
    sed -i "s/@KOB_VERSION@/$kob_version/g" $file
    sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/$KOB_ARCHIVE_DOWNLOAD_REPO/g" $file
    sed -i "s/@KOB_NAMESPACE@/$KOB_NAMESPACE/g" $file
    # renaming to remove .tmpl extension
    mv "$file" "${file//.tmpl/}"
done

# committing the changes
git add ~/KOBman/scripts/*.*
git commit -m "Update version of $branch to $kob_version"

#push release branch
git push -f origin $branch

#Push tag 
git tag -a $kob_version -m "Releasing version $kob_version"
git push origin $kob_version

#checkout to dev
git checkout dev

