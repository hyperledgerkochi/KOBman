#!/bin/bash

function __kob_list {
curl -sL "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/${KOBMAN_DIST_BRANCH}/dist/list.txt" > tmp.txt

echo "Available environments and their respective version numbers"
echo "---------------------------------------------------------------"
sed 's/,/ /g' tmp.txt > tmp1.txt
sed 's/,/ /g' tmp.txt | cut -d " " -f 1 > tmp2.txt
cat tmp1.txt | grep -h -f tmp2.txt > tmp3.txt
cat tmp3.txt
rm tmp*
}
