
#!/bin/bash

#Install: stable

# Global variables
KOBMAN_PLATFORM=$(uname)
export KOBMAN_SERVICE="https://raw.githubusercontent.com"

KOBMAN_NAMESPACE="hyperledgerkochi"
KOBMAN_VERSION="tag0a2"
KOBMAN_ENV_REPOS="$KOBMAN_NAMESPACE/kobman_env_repo"
# KOBMAN_DIST_BRANCH=${KOBMAN_DIST_BRANCH:-REL-${KOBMAN_VERSION}}



if [ -z "$KOBMAN_DIR" ]; then
    KOBMAN_DIR="$HOME/.kobman"
fi

# variables
kobman_bin_folder="${KOBMAN_DIR}/bin"
kobman_src_folder="${KOBMAN_DIR}/src"
kobman_tmp_folder="${KOBMAN_DIR}/tmp"
kobman_stage_folder="${kobman_tmp_folder}/stage"
kobman_zip_file="${kobman_tmp_folder}/kobman-${KOBMAN_VERSION}.zip"
kobman_env_folder="${KOBMAN_DIR}/envs"
kobman_stage_folder="${kobman_tmp_folder}/stage"
kobman_etc_folder="${KOBMAN_DIR}/etc"
kobman_var_folder="${KOBMAN_DIR}/var"
kobman_config_file="${kobman_etc_folder}/config"
kobman_user_config_file="${kobman_etc_folder}/user-config.cfg"
kobman_bash_profile="${HOME}/.bash_profile"
kobman_profile="${HOME}/.profile"
kobman_bashrc="${HOME}/.bashrc"
kobman_zshrc="${HOME}/.zshrc"




kobman_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR KOBMAN TO WORK!!!
export KOBMAN_DIR="$KOBMAN_DIR"
[[ -s "${KOBMAN_DIR}/bin/kobman-init.sh" ]] && source "${KOBMAN_DIR}/bin/kobman-init.sh"
EOF
)

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
case "$(uname)" in
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



figlet Setting up KOBman >> kobman.txt
cat kobman.txt
rm kobman.txt
# Sanity checks

echo "Looking for a previous installation of KOBMAN..."
if [ -d $KOBMAN_DIR/bin ]; then
	echo "KOBMAN found."
	echo ""
	echo "======================================================================================================"
	echo " You already have KOBMAN installed."
	echo " KOBMAN was found at:"
	echo ""
	echo "    ${KOBMAN_DIR}"
	echo ""
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ kob selfupdate force"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for unzip..."
if [ -z $(which unzip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for zip..."
if [ -z $(which zip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install zip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing zip."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

echo "Looking for curl..."
if [ -z $(which curl) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 1
fi

if [[ "$solaris" == true ]]; then
	echo "Looking for gsed..."
	if [ -z $(which gsed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install gsed on your solaris system."
		echo ""
		echo " KOBMAN uses gsed extensively."
		echo ""
		echo " Restart after installing gsed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
else
	echo "Looking for sed..."
	if [ -z $(which sed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install sed on your system using your favourite package manager."
		echo ""
		echo " Restart after installing sed."
		echo "======================================================================================================"
		echo ""
		exit 1
	fi
fi


echo "Installing KOBMAN scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "$kobman_bin_folder"
mkdir -p "$kobman_src_folder"
mkdir -p "$kobman_tmp_folder"
mkdir -p "$kobman_stage_folder"
mkdir -p "$kobman_env_folder"
mkdir -p "$kobman_etc_folder"
mkdir -p "$kobman_var_folder"



echo "Prime the config file..."
echo "config selfupdate/debug_mode = true"

touch "$kobman_config_file"
echo "kobman_auto_answer=false" >> "$kobman_config_file"
echo "kobman_auto_selfupdate=false" >> "$kobman_config_file"
echo "kobman_insecure_ssl=false" >> "$kobman_config_file"
echo "kobman_curl_connect_timeout=7" >> "$kobman_config_file"
echo "kobman_curl_max_time=10" >> "$kobman_config_file"
echo "kobman_beta_channel=false" >> "$kobman_config_file"
echo "kobman_debug_mode=true" >> "$kobman_config_file"
echo "kobman_colour_enable=true" >> "$kobman_config_file"

echo "Setting up user configs"
touch "$kobman_user_config_file"
echo "KOBMAN_VERSION=$KOBMAN_VERSION" >> "$kobman_user_config_file"
echo "KOBMAN_USER_NAMESPACE=" >> "$kobman_user_config_file"
echo "KOBMAN_ENV_ROOT=$HOME/KOBman_env" >> "$kobman_user_config_file"
echo "KOBMAN_NAMESPACE=hyperledgerkochi" >> "$kobman_user_config_file"
echo "KOBMAN_INTERACTIVE_USER_MODE=true" >> "$kobman_user_config_file"
echo "KOBMAN_DIR=$HOME/.kobman" >> "$kobman_user_config_file"
echo "KOBMAN_ENV_REPOS=$KOBMAN_ENV_REPOS" >> "$kobman_user_config_file"

echo "Download script archive..."

# once move to kobman namespace needs to update kobman-latest.zip 
curl -sL --location --progress-bar "${KOBMAN_SERVICE}/${KOBMAN_NAMESPACE}/KOBman/dist/dist/kobman-latest.zip" > "$kobman_zip_file"


ARCHIVE_OK=$(unzip -qt "$kobman_zip_file" | grep 'No errors detected in compressed data')
if [[ -z "$ARCHIVE_OK" ]]; then
	echo "Downloaded zip archive corrupt. Are you connected to the internet?"
	echo ""
	echo "If problems persist, please ask for help on our Github:"
	echo "* easy sign up: https://github.com/"
	echo "https://github.com/${KOBMAN_NAMESPACE}/KOBman/issues"
	rm -rf "$KOBMAN_DIR"
	exit 2
fi

echo "Extract script archive..."
if [[ "$cygwin" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	kobman_zip_file=$(cygpath -w "$kobman_zip_file")
	kobman_stage_folder=$(cygpath -w "$kobman_stage_folder")
fi
unzip -qo "$kobman_zip_file" -d "$kobman_stage_folder"


echo "Install scripts..."


#curl -sL "https://raw.githubusercontent.com/${KOBMAN_NAMESPACE}/KOBman/master/dist/environments" > tmp.txt
#sed -i 's/,/ /g' tmp.txt 
#environments=$(<tmp.txt)
#for i in $environments;
#do
#	mv "$kobman_stage_folder"/kobman-$i.sh "$kobman_env_folder"
#done 
#rm tmp.txt
mv "${kobman_stage_folder}"/dist/list.txt "$kobman_var_folder"
mv "${kobman_stage_folder}"/src/main/bash/kobman-init.sh "$kobman_bin_folder"
mv "${kobman_stage_folder}"/src/main/bash/commands/* "$kobman_src_folder"
mv "${kobman_stage_folder}"/src/main/bash/envs/* "$kobman_env_folder"
mv "${kobman_stage_folder}"/src/main/bash/kobman-main.sh "$kobman_src_folder"
mv "${kobman_stage_folder}"/src/main/bash/kobman-utils.sh "$kobman_src_folder"
mv "${kobman_stage_folder}"/src/main/bash/kobman-env-helpers.sh "$kobman_src_folder"
mv "${kobman_stage_folder}"/src/services "$kobman_src_folder"
#mv "${kobman_stage_folder}/kobman-init.sh" "$kobman_bin_folder"
#mv "$kobman_stage_folder"/kobman-* "$kobman_src_folder"
#mv "$kobman_stage_folder"/list.txt "$kobman_var_folder"
[[ -d ${kobman_stage_folder} ]] && rm -rf ${kobman_stage_folder}/*

echo "Set version to $KOBMAN_VERSION ..."
echo "$KOBMAN_VERSION" > "${KOBMAN_DIR}/var/version.txt"
function download_from_env_repo
{
	echo "checking for external repos..."
	env_repos=$(echo "$KOBMAN_ENV_REPOS" | sed 's/,/ /g')
	cached_list="$KOBMAN_DIR/var/list.txt"
	zip_stage_folder="$HOME/zip_stage_folder"
	mkdir -p "$zip_stage_folder"
	echo "Downloading environment files from $KOBMAN_ENV_REPOS"
	for i in ${env_repos[@]}; do
		namespace=$(echo $i | cut -d "/" -f 1)
		repo_name=$(echo $i | cut -d "/" -f 2)
		if curl -s "https://api.github.com/repos/$namespace/$repo_name" | grep -q "Not Found"
		then
			continue
		fi
		curl -sL "https://github.com/$namespace/$repo_name/archive/master.zip" -o "$HOME/$repo_name.zip"
		unzip -q "$HOME/$repo_name.zip" -d "$zip_stage_folder"
		remote_list="$zip_stage_folder/$repo_name-master/list.txt"
		if [[ ! -f "$remote_list" ]]; then
			echo "Error:No list file found for $repo_name"
			rm -rf "$zip_stage_folder"
			continue
		fi
		environment_files=$(find $zip_stage_folder/$repo_name-master -type f -name "kobman-*.sh")
		if [[ -z "${environment_files}" ]]; then
			echo "No environment files found for $namespace/$repo_name"
			continue
		fi
		for j in ${environment_files[@]}; do
			trimmed_file_name="${j##*/}"
			environment=$(echo "$trimmed_file_name" | cut -d "-" -f 2 | sed 's/.sh//g')
			if cat "$cached_list" | grep -qw "$namespace/$repo_name/$environment" 
			then
				continue
			fi
			mv "$j" "$KOBMAN_DIR"/envs/
			echo "" >> $cached_list
			cat "$remote_list" | grep "$namespace/$repo_name/$environment"  >> "$cached_list"
		done
		rm "$HOME/$repo_name.zip"
	done
	if [[ -d $zip_stage_folder ]]; then 
		rm -rf $zip_stage_folder
	fi
	unset environment_files namespace repo_name trimmed_file_name environment zip_stage_folder cached_list remote_list
}
download_from_env_repo
if [[ $darwin == true ]]; then
  touch "$kobman_bash_profile"
  echo "Attempt update of login bash profile on OSX..."
  if [[ -z $(grep 'kobman-init.sh' "$kobman_bash_profile") ]]; then
    echo -e "\n$kobman_init_snippet" >> "$kobman_bash_profile"
    echo "Added kobman init snippet to $kobman_bash_profile"
  fi
else
  echo "Attempt update of interactive bash profile on regular UNIX..."
  touch "${kobman_bashrc}"
  if [[ -z $(grep 'kobman-init.sh' "$kobman_bashrc") ]]; then
      echo -e "\n$kobman_init_snippet" >> "$kobman_bashrc"
      echo "Added kobman init snippet to $kobman_bashrc"
  fi
fi

echo "Attempt update of zsh profile..."
touch "$kobman_zshrc"
if [[ -z $(grep 'kobman-init.sh' "$kobman_zshrc") ]]; then
    echo -e "\n$kobman_init_snippet" >> "$kobman_zshrc"
    echo "Updated existing ${kobman_zshrc}"
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${KOBMAN_DIR}/bin/kobman-init.sh\""

echo "    "
echo "Then issue the following command:"
echo ""
echo "    kob help"
echo ""

echo "Enjoy!!!"