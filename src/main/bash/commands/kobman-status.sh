#!/bin/bash


function __kob_status {

file=($(find $KOBMAN_DIR/envs/ -name "kob_env_*" -print))
__kobman_echo_yellow "Installed environments/ version"
__kobman_echo_yellow "--------------------------------"
for f in "${file[@]}"; do
	# echo "$f"
    n=${f##*_}
    # cd $KOBMAN_DIR/envs/kob_env_$n
    if [[ $n == $(cat $KOBMAN_DIR/var/current) ]]; then
        echo "~" $n $(ls $KOBMAN_DIR/envs/kob_env_$n | grep -v $(cat $KOBMAN_DIR/var/current)) $(cat $KOBMAN_DIR/var/current)"*" > $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
        sed 's/current//g' $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    else

        echo $n $(ls $KOBMAN_DIR/envs/kob_env_$n | grep -v $(cat $KOBMAN_DIR/var/current)) $(cat $KOBMAN_DIR/var/current)"*" > $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
        sed 's/current//g' $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    fi
    rm $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    
done
# echo $file

# cat tmp.txt

unset n file f 
}
