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
# TODO FIX  ~/KOBman may not be the suitable folder name as there would be name clash, use build instead. 
mkdir -p build/tmp

# making of tar files
tar -cvf build/tmp/kobman-latest.tar ~/KOBman/src/ 
cp build/tmp/kobman-latest.tar build/tmp/kobman-$kob_rel_version.tar

# moving get.kobman.io to tmp/
mv ~/KOBman/scripts/get.kobman.io build/tmp/

# moving into dist branch
git checkout $dist_branch

# collecting files from Release branch tmp/ folder to dist branch
git checkout $branch -- ~/KOBman/build/tmp/* &> /dev/null

mkdir dist
# moving of latest files from tmp/ to dist/
mv build/tmp/* dist/

# saving changes and pushing
git add dist/*
git commit -m "Released the version $kob_rel_version"
git push origin $dist_branch


git checkout dev





