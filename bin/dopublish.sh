#!/bin/bash

kob_rel_version=$1
branch="release"
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

zip -rj $HOME/KOBman/build/tmp/kobman-latest.zip $HOME/KOBman/dist/list.txt $HOME/KOBman/src/main/bash/kobman-* $HOME/KOBman/src/main/bash/envs/kobman-* $HOME/KOBman/src/main/bash/commands/kobman-*

#zip -r build/tmp/kobman-latest.zip $HOME/KOBman/src/
cp $HOME/KOBman/build/tmp/kobman-latest.zip $HOME/KOBman/build/tmp/kobman-$kob_rel_version.zip

# moving get.kobman.io to tmp/
mv $HOME/KOBman/scripts/get.kobman.io $HOME/KOBman/build/tmp/

# moving into dist branch
git checkout $dist_branch

# collecting files from Release branch tmp/ folder to dist branch
git checkout $branch -- $HOME/KOBman/build/tmp/* &> /dev/null

mkdir dist &> /dev/null
# moving of latest files from tmp/ to dist/
mv $HOME/KOBman/build/tmp/* $HOME/KOBman/dist/

# ls -l $HOME/KOBman/dist/
# saving changes and pushing
git add $HOME/KOBman/dist/*
git commit -m "Released the version $kob_rel_version"
git push origin -f -u $dist_branch

#checkout back to master
git checkout master
