#!/bin/bash

branch=Release
kob_rel_version=$1
dist_branch=dist


#Checkout latest tag
# git checkout tags/$kob_rel_version -b $kob_rel_version
git checkout $branch

mkdir -p ~/KOBman/dist

echo "making the tar files..."
tar -cvf ~/KOBman/dist/kobman-latest.tar ~/KOBman/src/ 
cp ~/KOBman/dist/kobman-latest.tar ~/KOBman/dist/kobman-$kob_rel_version.tar

# moving get.kobman.io to dist
mv ~/KOBman/scripts/get.kobman.io ~/KOBman/dist/
ls ~/KOBman/dist/
# moving into dist branch
git checkout $dist_branch
for file in ~/KOBman/dist/*;
do
    git checkout $branch -- $file &> /dev/null

done

echo "saving changes and pushing"
git add .
git commit -m "Released the version $kob_rel_version"
git push origin $dist_branch


git checkout dev





