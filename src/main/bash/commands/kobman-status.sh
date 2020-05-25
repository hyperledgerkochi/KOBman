#!/bin/bash


function __kob_status {

cd $KOBMAN_DIR/envs
file=($(find -name "kob_env_*" -print))
echo "Installed environments and their version"
echo "---------------------------------------------"
for f in "${file[@]}"; do
	# echo "$f"
    n=${f##*_}
    cd $KOBMAN_DIR/envs/kob_env_$n


    echo $n $(ls $KOBMAN_DIR/envs/kob_env_$n | grep -v $(cat current)) $(cat current)"*" > tmp.txt
    sed 's/current//g' $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    rm tmp.txt
    
done
# echo $file

# cat tmp.txt

unset n file f 
}
