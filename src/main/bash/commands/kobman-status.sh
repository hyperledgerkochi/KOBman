#!/bin/bash


function __kob_status {
file=($(find $KOBMAN_DIR/envs/ -name "kob_env_*" -print))
__kobman_echo_white "Installed environments and their version"
__kobman_echo_white "---------------------------------------------"
for f in "${file[@]}"; do
	
    n=${f##*_}
    if [[ $n == $(cat $KOBMAN_DIR/var/current) ]]; then
        __kobman_echo_white "~" $n $(ls $KOBMAN_DIR/envs/kob_env_$n | grep -v $(cat $KOBMAN_DIR/envs/kob_env_$n/current)) $(cat $KOBMAN_DIR/envs/kob_env_$n/current)"*" > $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
        sed 's/current//g' $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    else

        __kobman_echo_white $n $(ls $KOBMAN_DIR/envs/kob_env_$n | grep -v $(cat $KOBMAN_DIR/envs/kob_env_$n/current)) $(cat $KOBMAN_DIR/envs/kob_env_$n/current)"*" > $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
        sed 's/current//g' $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    fi
    rm $KOBMAN_DIR/envs/kob_env_$n/tmp.txt
    
done

unset n file f 

}
