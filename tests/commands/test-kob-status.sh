#!/bin/bash

status="true"

function __test_kob_init
{
    echo "Checking for kob..."
    if [[ -d $KOBMAN_DIR ]]; then
        source $KOBMAN_DIR/src/kobman-utils.sh
        __kobman_echo_no_colour "kob found"
        source $KOBMAN_DIR/bin/kobman-init.sh
    else
        status="false"
        echo "kob not found"
        echo "Please install KOBman first and try again"
        echo "Exiting!!!"
        exit 1
        
    fi
    
    __kobman_echo_no_colour "Checking for installed environments...."
    env_folder=($(find $KOBMAN_DIR/envs/ -name "kob_env_*" -print))
    if [[ -z $env_folder ]]; then
        __kobman_echo_no_colour "No environments installed"
        __kobman_echo_no_colour "Please install an enivornment first and try again"
        __kobman_echo_no_colour "Exiting!!!"
        status="false"
        return 1
    else
        __kobman_echo_no_colour "Environments found"
        __kobman_echo_no_colour "Proceeding with the test..."
    fi

}

function __test_kob_execute
{
    __kobman_echo_no_colour "Executing status command"
    kob status >> tmp.txt

}

function __test_kob_validate
{

    __kobman_echo_no_colour "Validating...."
    for i in "${env_folder[@]}"; do
        n=${i##*_}
        cat tmp.txt | grep -qw $n
        if [[ "$?" != "0" ]]; then
            __kobman_echo_no_colour "could not find environemnt $n in the status"
            status="false"
            return 1
        fi
        
        cat tmp.txt | grep -w $n | grep -w "$(cat $i/current)" | grep -q "*"
        if [[ "$?" != "0" ]]; then
            __kobman_echo_no_colour "The current version is not represented properly for $n"
            status=false
            return 1
        fi
    done

    cat tmp.txt | grep -w $(cat $KOBMAN_DIR/var/current) | grep -q "~"
    if [[ "$?" != "0" ]]; then
        __kobman_echo_no_colour "~ is not against the last installed environment"
        status="false"
        return 1
    fi
}   

function __test_kob_cleanup
{
    rm tmp.txt
}

function __test_kob_run
{
    if [[ $status == "true" ]]; then
        __test_kob_init
    else
        return 1
    fi

    if [[ $status == "true" ]]; then
        __test_kob_execute
    else
        return 1
    fi

    if [[ $status == "true" ]]; then
        __test_kob_validate 
    else
        __test_kob_cleanup
        return 1
    fi
    __test_kob_cleanup

}

__test_kob_run
if [[ $status == "true" ]]; then
    __kobman_echo_green "test-kob-status success"
else
    __kobman_echo_red "test-kob-status failed"
fi