#!/bin/bash

kob_rel_version=$1
branch="Release"
dist_branch="dist"

#sanity
if [[ -z "$kob_rel_version" ]]; then
	echo "Usage: dopublish.sh <version>"
	exit 0
fi

#Checkout latest tag
# git checkout tags/$kob_rel_version -b $kob_rel_version
git checkout $branch


# temporary folder for storing tar files. folder also added in .gitignore
mkdir -p build/tmp

# making of zip files
zip -rj ~/KOBman/build/tmp/kobman-latest.zip ~/KOBman/dist/list.txt ~/KOBman/src/main/bash/kobman-* ~/KOBman/src/main/bash/envs/kobman-* ~/KOBman/src/main/bash/commands/kobman-*

#zip -r build/tmp/kobman-latest.zip ~/KOBman/src/
cp ~/KOBman/build/tmp/kobman-latest.zip ~/KOBman/build/tmp/kobman-$kob_rel_version.zip

# moving get.kobman.io to tmp/
mv ~/KOBman/scripts/get.kobman.io ~/KOBman/build/tmp/

# moving into dist branch
git checkout $dist_branch

# collecting files from Release branch tmp/ folder to dist branch
git checkout $branch -- ~/KOBman/build/tmp/* &> /dev/null

mkdir dist &> /dev/null
# moving of latest files from tmp/ to dist/
mv ~/KOBman/build/tmp/* ~/KOBman/dist/

# saving changes and pushing
git add ~/KOBman/dist/*
git commit -m "Released the version $kob_rel_version"
git push origin -f $dist_branch

#checkout back to master
git checkout master
