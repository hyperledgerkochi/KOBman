

#!/bin/bash

path_to_kob_envs="${KOBMAN_DIR}/envs"
environment=$1
version=$2
if [[ -z $environment || -z $version ]]; then
    echo "Usage: ./test-kob-version.sh <env_name> <version>"
    exit 1
fi
function __test_kob_init
{
    if [[ -d $KOBMAN_DIR ]]; then
        source $KOBMAN_DIR/src/kobman-utils.sh
        __kobman_echo_no_colour "kob found"
        source $KOBMAN_DIR/bin/kobman-init.sh
    else
        echo "kob not found"
        echo "Please install KOBman and try again"
        echo "Exiting!!1"
        exit 1
    fi
    if [[ ! -f $KOBMAN_DIR/var/version.txt ]]; then
        __kobman_echo_no_colour "Could not find version.txt"
        __kobman_echo_no_colour "Try reinstalling KOBman"
        __kobman_echo_no_colour "Exiting!!!"
        exit 1
    fi

    __kobman_echo_no_colour "Creating and sourcing dummyenv files..."
    touch $KOBMAN_DIR/var/kobman_env_${environment}.proc
    create_install_dummyenv_script > $path_to_kob_envs/kobman-$environment.sh
    source $path_to_kob_envs/kobman-${environment}.sh
    fake_publish_dummyenv


}
function __test_kob_execute
{
    __kobman_echo_no_colour "Installing dummyenv"
    kob install -env $environment -V $version >> ~/output.txt
    cat ~/output.txt | grep -q "dummyenv installed"
    if [[ "$?" == "0" ]]; then
        __kobman_echo_no_colour "0" > $KOBMAN_DIR/var/kobman_env_$environment.proc
        __kobman_echo_white "$environment version details"
        __kobman_echo_white "----------------"
        kob -V -env $environment
    else
        __kobman_echo_no_colour "1" > $KOBMAN_DIR/var/kobman_env_$environment.proc
    fi


# version checking
    __kobman_echo_no_colour "Executing version command for utility & environments"
    kob version >> tmp.txt
    kob -V -env $environment >> tmp1.txt

}
function __test_kob_validate
{
    __kobman_echo_no_colour "validating version command..."
    if [[ $(cat $KOBMAN_DIR/var/kobman_env_$environment.proc) == "1" ]]; then
        __kobman_echo_no_colour "install command did not execute properly"
        test_status="failed"
        return 1
    fi

    cat tmp.txt | grep -qw "KOBman version [0-9].[0-9].[0-9]"
    if [[ "$?" != "0" ]]; then
        __kobman_echo_no_colour "no version details available"
        test_status="failed"
        return 1
    fi

    if [[ ! -f $path_to_kob_envs/kob_env_$environment/current ]]; then
        __kobman_echo_no_colour "Could not find $environment/current "
        return 1
    fi

    cat tmp1.txt | grep -qw "$environment version [0-9].[0-9].[0-9]"
    if [[ "$?" != "0" ]]; then
        __kobman_echo_no_colour "no $environment version details available"
        test_status="failed"
        return 1
    fi

}

function __test_kob_cleanup
{
    rm ~/output.txt ~/tmp1.txt ~/tmp.txt $KOBMAN_DIR/var/kobman_env_${environment}.proc $path_to_kob_envs/kobman-$environment.sh
    rm -rf $path_to_kob_envs/kob_env_$environment Dev_$environment
    sed -i "s/dummyenv,0.0.2,0.0.3,0.0.5,0.0.7,0.0.9//g" $KOBMAN_DIR/var/list.txt
}

function fake_publish_dummyenv
{
  __kobman_echo_no_colour "dummyenv,0.0.2,0.0.3,0.0.5,0.0.7,0.0.9" >> $KOBMAN_DIR/var/list.txt
  source $KOBMAN_DIR/bin/kobman-init.sh
}
function create_install_dummyenv_script(){

cat <<EOF
#!/bin/bash
function __kobman_install_dummyenv
{

  cd ~
  if [ ! -d "Dev_dummyenv" ]; then

    __kobman_create_dev_environment
    __kobman_echo_white "dummyenv installed"
  else

    rm -rf ~/Dev_dummyenv
    __kobman_create_dev_environment
    __kobman_echo_white "dummyenv installed"

  fi
}
function __kobman_uninstall_dummyenv
{
    rm  -rf ~/Dev_dummyenv

}
function __kobman_update_dummyenv
{
    __kobman_echo_white "update"
}
function __kobman_upgrade_dummyenv
{
    __kobman_echo_white "upgraded"
}
function __kobman_start_dummyenv
{
    __kobman_echo_white "start"
}
function __kobman_stop_dummyenv
{
    __kobman_echo_white "stop"
}
function __kobman_create_dev_environment
{

	cd ~
	mkdir -p Dev_dummyenv
	cd Dev_dummyenv
	export DUMMYENV_DEV_DIR=$PWD
	mkdir -p test/ dependency/
}
EOF
}
function __test_kob_run
{
    test_status="success"
    __test_kob_init
    __test_kob_execute
    __test_kob_validate
    __test_kob_cleanup
    if [[ $test_status == "success" ]]; then
        __kobman_echo_green "test-kob-version success"
    else
        __kobman_echo_red "test-kob-version failed"
    fi
}
__test_kob_run
