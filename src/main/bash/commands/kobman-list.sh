#!/bin/bash

# if [[ -z KOBMAN_NAMESPACE ]]; then

#     KOBMAN_NAMESPACE=${KOBMAN_NAMESPACE:-hyperledgerkochi}
# fi

function __kob_list {

curl -s -L "https://raw.githubusercontent.com/$KOBMAN_NAMESPACE/KOBman/dev/dist/list" > tmp.txt

envs="Von-Network TheOrgBook greenlight kobman KOBConnect KOBRegistry KochiOrgBook KOBDflow KOBVON"
echo "Available environments and their respective version numbers"
echo "-----------------------------------------------------------"
for i in $envs; do
    
    cat tmp.txt | grep -h "^$i [0-9].[0-9].[0-9]" >> tmp1.txt
done
cat tmp1.txt
rm tmp*
# for i in $envs; do

#     cat tmp1.txt | grep -h -w $i >> tmp2.txt
# done
# cat tmp2.txt
}



