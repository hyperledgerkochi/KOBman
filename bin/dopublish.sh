#!/bin/bash

branch=Release
kob_rel_version=$1
dist_branch=dist


#Checkout latest tag
# git checkout tags/$kob_rel_version -b $kob_rel_version
git checkout $branch

# temporary folder for storing tar files. folder also added in .gitignore
mkdir -p ~/KOBman/tmp

# making of tar files
tar -cvf ~/KOBman/tmp/kobman-latest.tar ~/KOBman/src/ 
cp ~/KOBman/tmp/kobman-latest.tar ~/KOBman/tmp/kobman-$kob_rel_version.tar

# moving get.kobman.io to tmp/
mv ~/KOBman/scripts/get.kobman.io ~/KOBman/tmp/

# moving into dist branch
git checkout $dist_branch

# collecting files from Release branch tmp/ folder to dist branch
git checkout $branch -- ~/KOBman/tmp/* &> /dev/null

# moving of latest files from tmp/ to dist/
mv tmp/* dist/

# saving changes and pushing
git add dist/*
git commit -m "Released the version $kob_rel_version"
git push origin $dist_branch


git checkout dev





