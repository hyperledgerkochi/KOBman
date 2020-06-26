
#!/bin/bash


function __test_kob_init
{
    if [[ -d $KOBMAN_DIR ]]; then
        source $KOBMAN_DIR/src/kobman-utils.sh
        __kobman_echo_no_colour "kob found"
        source $KOBMAN_DIR/bin/kobman-init.sh
    else
        test_status="failed"
        echo "kob not found"
        echo "Please install KOBman first and try again"
        echo "Exiting!!!"
        exit 1

    fi

    __kobman_echo_no_colour "Checking for installed version file...."


    if [[ ! -f $KOBMAN_DIR/var/version.txt ]]; then
         __kobman_echo_no_colour "No version file found"
         __kobman_echo_no_colour "Please re-install and try again"
         __kobman_echo_no_colour "Exiting!!!"
         test_status="failed"
         exit
    else
         __kobman_echo_no_colour "version file found "
         __kobman_echo_no_colour "Proceeding with the test..."
    fi

}

function __test_kob_execute
{
    __kobman_echo_no_colour "Executing version command"
    kob version >> tmp.txt

}

function __test_kob_validate
{

    __kobman_echo_no_colour "Validating...."

    cat tmp.txt | grep -qw "KOBman version [0-9].[0-9].[0-9]"
    if [[ "$?" != "0" ]]; then
        __kobman_echo_no_colour "no version details available"
        test_status="failed"
        return 1
    fi
}

function __test_kob_cleanup
{
    rm tmp.txt
}

function __test_kob_run
{
    test_status="success"

    __test_kob_init
    __test_kob_execute
    __test_kob_validate
    __test_kob_cleanup

    if [[ $test_status == "success" ]]; then
	__kobman_echo_no_colour "test-kob-version success"
    else
	__kobman_echo_no_colour "test-kob-version failed"
    fi

}

__test_kob_run
