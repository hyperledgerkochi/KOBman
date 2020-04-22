#!/usr/bin/env bash


# set env vars if not set
if [ -z "$KOBMAN_VERSION" ]; then
	export KOBMAN_VERSION="@KOBMAN_VERSION@"
fi



export KOBMAN_SERVICE="https://raw.githubusercontent.com"
export KOBMAN_NAMESPACE="EtricKombat"

#if [ -z "$KOBMAN_CANDIDATES_API" ]; then
#	export KOBMAN_CANDIDATES_API="@KOBMAN_CANDIDATES_API@"
#fi

if [ -z "$KOBMAN_DIR" ]; then
	export KOBMAN_DIR="$HOME/.kobman"
fi



# infer platform
KOBMAN_PLATFORM="$(uname)"
if [[ "$KOBMAN_PLATFORM" == 'Linux' ]]; then
	if [[ "$(uname -m)" == 'i686' ]]; then
		KOBMAN_PLATFORM+='32'
	else
		KOBMAN_PLATFORM+='64'
	fi
fi
export KOBMAN_PLATFORM

# OS specific support (must be 'true' or 'false').
cygwin=false
darwin=false
solaris=false
freebsd=false
case "${KOBMAN_PLATFORM}" in
	CYGWIN*)
		cygwin=true
		;;
	Darwin*)
		darwin=true
		;;
	SunOS*)
		solaris=true
		;;
	FreeBSD*)
		freebsd=true
esac

# Determine shell
zsh_shell=false
bash_shell=false

if [[ -n "$ZSH_VERSION" ]]; then
	zsh_shell=true
else
	bash_shell=true
fi

# Source kobman module scripts and environment files.
#
# Extension files are prefixed with 'kobman-' and found in the env/ folder.
# Use this if environments are written with the functional approach and want
# to use functions in the main kobman script. For more details, refer to
# <https://github.com/kobman/kobman-extensions>.
OLD_IFS="$IFS"
IFS=$'\n'
scripts=($(find "${KOBMAN_DIR}/src" "${KOBMAN_DIR}/envs" -type f -name 'kobman-*'))
for f in "${scripts[@]}"; do
	source "$f"
done
IFS="$OLD_IFS"
unset scripts f

# Load the kobman config if it exists.
if [ -f "${KOBMAN_DIR}/etc/config" ]; then
	source "${KOBMAN_DIR}/etc/config"
fi

## Create upgrade delay file if it doesn't exist
#if [[ ! -f "${KOBMAN_DIR}/var/delay_upgrade" ]]; then
#	touch "${KOBMAN_DIR}/var/delay_upgrade"
#fi
#
## set curl connect-timeout and max-time
#if [[ -z "$kobman_curl_connect_timeout" ]]; then kobman_curl_connect_timeout=7; fi
#if [[ -z "$kobman_curl_max_time" ]]; then kobman_curl_max_time=10; fi
#
## set curl retry
#if [[ -z "${kobman_curl_retry}" ]]; then kobman_curl_retry=0; fi
#
## set curl retry max time in seconds
#if [[ -z "${kobman_curl_retry_max_time}" ]]; then kobman_curl_retry_max_time=60; fi
#
## set curl to continue downloading automatically
#if [[ -z "${kobman_curl_continue}" ]]; then kobman_curl_continue=true; fi
#
## Read list of candidates and set array
#KOBMAN_CANDIDATES_CACHE="${KOBMAN_DIR}/var/candidates"
#KOBMAN_CANDIDATES_CSV=$(<"$KOBMAN_CANDIDATES_CACHE")
#__kobman_echo_debug "Setting candidates csv: $KOBMAN_CANDIDATES_CSV"
#if [[ "$zsh_shell" == 'true' ]]; then
#	KOBMAN_CANDIDATES=(${(s:,:)KOBMAN_CANDIDATES_CSV})
#else
#	OLD_IFS="$IFS"
#	IFS=","
#        KOBMAN_CANDIDATES=(${KOBMAN_CANDIDATES_CSV})
#	IFS="$OLD_IFS"
#fi

export KOBMAN_CANDIDATES_DIR=$HOME


# sudo chmod 777 ${KOBMAN_CANDIDATES_DIR}

#for candidate_name in "${KOBMAN_CANDIDATES[@]}"; do
#	candidate_dir="${KOBMAN_CANDIDATES_DIR}/${candidate_name}/current"
#	if [[ -h "$candidate_dir" || -d "${candidate_dir}" ]]; then
#		__kobman_export_candidate_home "$candidate_name" "$candidate_dir"
#		__kobman_prepend_candidate_to_path "$candidate_dir"
#	fi
#done
unset OLD_IFS candidate_name candidate_dir
export PATH
