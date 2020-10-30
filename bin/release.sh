#!/bin/bash

kob_version="$1"

branch="release"

# sanity check
if [[ -z "$kob_version" ]];
    then
        echo "Usage: release.sh <version>"
        exit 0
fi

#setting up environment variables
if [[ -z $KOB_ARCHIVE_DOWNLOAD_REPO ]];
    then
        KOB_ARCHIVE_DOWNLOAD_REPO={KOB_ARCHIVE_DOWNLOAD_REPO:-KOBman}
fi

if [[ -z $KOBMAN_NAMESPACE ]];
    then
        KOBMAN_NAMESPACE={KOBMAN_NAMESPACE:-hyperledgerkochi}
fi

# prepare branch
cd $HOME/KOBman
git checkout master
git branch -D $branch
git checkout -b $branch


#copy the tmpl file to /scripts
cp $HOME/KOBman/scripts/tmpl/*.tmpl $HOME/KOBman/scripts/
# replacing @xxx@ variables with acutal values.
for file in $HOME/KOBman/scripts/*.tmpl;
do
    sed -i "s/@KOB_VERSION@/$kob_version/g" $file
    sed -i "s/@KOB_ARCHIVE_DOWNLOAD_REPO@/$KOB_ARCHIVE_DOWNLOAD_REPO/g" $file
    sed -i "s/@KOB_NAMESPACE@/$KOBMAN_NAMESPACE/g" $file
    # renaming to remove .tmpl extension
    mv "$file" "${file//.tmpl/}"
done

# committing the changes
git add $HOME/KOBman/scripts/*.*
git commit -m "Update version of $branch to $kob_version"

#push release branch
git push -f -u origin $branch

#Push tag
git tag -a $kob_version -m "Releasing version $kob_version"
git push origin $kob_version

#checkout to master
git checkout master
