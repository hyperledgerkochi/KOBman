#!/bin/bash

path_to_kob_envs="${KOBMAN_DIR}/envs"
path_to_kob_env_tests=~/KOBman/tests/envs
kobman_env_name=${1:-dummyenv}
version=$2
KOBMAN_NAMESPACE=${KOBMAN_NAMESPACE:-hyperledgerkochi}
status="true"

function __test_kob_run
{
  __test_kob_init
  
  __test_kob_execute
  __test_kob_validate || return 1

   __test_kob_cleanup 

  __test_kob_install_output
  
  
}

function __test_kob_init {
  echo "checking for kob..."

  if [[ -d ${KOBMAN_DIR} ]]; then

    echo "kob found"
    source "${KOBMAN_DIR}/bin/kobman-init.sh"
  
  else
  
    echo "kob not found"
    echo "installing kobman...."
    curl -L https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/get.kobman.io | bash > /dev/null 2>&1
    source "${KOBMAN_DIR}/bin/kobman-init.sh"
  
  fi
  
  echo "creating and sourcing dummyenv files..."
  touch $KOBMAN_DIR/var/kobman_env_$kobman_env_name.proc
  
  __test_kob_insert_dummyenv_version
  
  __test_kob_install_dummyenv_script > $path_to_kob_envs/kobman-$kobman_env_name.sh
  
  touch $path_to_kob_env_tests/test-kobman-${kobman_env_name}.sh
  __test_kob_dummyenv_validation > $path_to_kob_env_tests/test-kobman-${kobman_env_name}.sh
  
  source $path_to_kob_envs/kobman-$kobman_env_name.sh


}

function __test_kob_execute {
  echo "executing install command..."
  kob install --environment ${kobman_env_name} --version $version > ~/output.txt
#   echo "output.txt"
#   cat ~/output.txt
   
  cat ~/output.txt | grep -q "dummyenv installed"
  
  if [[ "$?" == "0" ]]; then
  
    echo "0" > $KOBMAN_DIR/var/kobman_env_$kobman_env_name.proc
  
  else
  
    echo "1" > $KOBMAN_DIR/var/kobman_env_$kobman_env_name.proc    
  
  fi
}


function __test_kob_validate {
  
  echo "validating install command...."
  . $path_to_kob_env_tests/test-kobman-${kobman_env_name}.sh  > ~/tmp.txt
  

  
  if [[ $(cat $KOBMAN_DIR/var/kobman_env_$kobman_env_name.proc) == "1" ]]; then
    
    echo "install command did not execute properly"
    status="fail"
    __test_kob_cleanup
    __test_kob_install_output
    return 1
  
  fi

  tail -1 ~/tmp.txt | grep -q "success"
  if [[ "$?" != "0" ]]; then
  
    echo "output of dummy env validate is: failed"
    status="fail"
    __test_kob_cleanup
    __test_kob_install_output
    return 1
  fi
  
  if [[ ! -d ~/Dev_${kobman_env_name} ]]; then
    
    echo "Dev_${kobman_env_name} was not found in the /home folder"
    status="fail"
    __test_kob_cleanup
    __test_kob_install_output
    return 1
  
  fi
  
  if [[ ! -d $KOBMAN_DIR/envs/kob_env_${kobman_env_name} || $(cat $KOBMAN_DIR/envs/kob_env_${kobman_env_name}/current) != $version ]]; then
    
    echo "error in .kobman/envs"
    status="fail"
    __test_kob_cleanup
    __test_kob_install_output
    return 1
  
  fi
  
}



function __test_kob_install_output
{
  
  if [ $status == "true" ]; then
  
    echo "test_kob_install success"
  
  else  
  
    echo "test_kob_install failed"
  
  fi
}

function __test_kob_cleanup()
{
  
  rm ~/output.txt ~/tmp.txt $path_to_kob_env_tests/test-kobman-${kobman_env_name}.sh $path_to_kob_envs/kobman-$kobman_env_name.sh $KOBMAN_DIR/var/kobman_env_$kobman_env_name.proc
  rm -rf ~/Dev_dummyenv 
  rm -rf $path_to_kob_envs/kob_env_$kobman_env_name

}




function __test_kob_install_dummyenv_script(){
  
cat <<EOF
#!/bin/bash

function __kobman_install_dummyenv
{
  __kobman_install
  __kobman_uninstall
  __kobman_update
  __kobman_upgrade
  __kobman_start
  __kobman_stop
}
function __kobman_install
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
function __kobman_uninstall
{
    __kobman_echo_white "uninstalled"
}
function __kobman_update
{
    __kobman_echo_white "updated"
}
function __kobman_upgrade
{
    __kobman_echo_white "upgraded"

}
function __kobman_start
{
    __kobman_echo_white "start"
}
function __kobman_stop
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

function __test_kob_dummyenv_validation()
{

cat <<EOF
  #!/bin/bash
  status="true"
  function __test_kob_dummyenv_run
  {
    __test_kob_init || return 1
    
    __test_kob_execute
    
    __test_kob_validate || return 1
    __test_kob_cleanup
    __test_kob_output
  }
  function __test_kob_init
  {
    
    if [[ ! -d ~/Dev_dummyenv ]]; then
      
      status="false"
      __test_kob_output
      return 1
    else
      
      return 0

    fi

  }
  function __test_kob_execute
  {
    
    touch ~/dummy.txt
    # echo "output of execute of dummyenv" > ~/dummy.txt
    

    

  }
  function __test_kob_validate
  {
    
    
    ls ~ | grep -qw "dummy.txt"
    if [[ "$?" != "0" ]]; then
      status="false"
      __test_kob_output
      __test_kob_cleanup
      return 1
    fi

    if [[ "$(cat $KOBMAN_DIR/var/kobman_env_dummyenv.proc)" == "1" ]]; then
      
      status="false"
      __test_kob_output
      __test_kob_cleanup
      return 1

    fi
   return 0 
  }

  function __test_kob_cleanup
  {
    rm -rf ~/dummy.txt
  }

  function __test_kob_output
  {
    
    if [[ $status == "true" ]]; then
      echo "success"
    else
      echo "failed"
    fi
  }
  __test_kob_dummyenv_run


EOF
}

function __test_kob_insert_dummyenv_version
{
  
  rm $KOBMAN_DIR/var/list.txt

  curl -sL https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/list.txt > $KOBMAN_DIR/var/list.txt
  

  echo "dummyenv,0.0.2,0.0.3,0.0.5,0.0.7,0.0.9" >> $KOBMAN_DIR/var/list.txt
  
  
  source $KOBMAN_DIR/bin/kobman-init.sh
  
}
__test_kob_run




