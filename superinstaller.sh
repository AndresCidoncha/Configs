#!/bin/bash

source ./terminal_colors.sh


function execSteps {
	steps=$(echo $1 | sed -e "s/\(\[\s\|\s\]\)//g" | tr "," "\n")
	OIFS="$IFS"
	IFS=$'\n'
	for step in $steps; do
		eval ${step}
	done
	IFS="$OIFS"
}

function addRepo {
	echo -e "\tADDING REPO: $1"
	if ! grep -q "^deb .*${1#ppa:}" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
		sudo add-apt-repository -y $1
		sudo apt -qq update
	else
		echo -e "\tAlready added"
	fi
}

function installPackage {
	echo -e "\tINSTALLING $1 PACKAGE"
	if [ ! -z $2 ]; then
		echo -e "\tADDITIONAL PACKAGES: ${*:2}"
	fi
	sudo apt-get -qq install -y $1 $*
}

function execPostSteps {
	echo -e "\tEXECUTING POST_STEPS: $*"
}


for dependency in `cat dependencies.txt`; do
	if ! which $dependency > /dev/null; then
		sudo apt-get -qq install -y $dependency
	fi
done

json=$(cat programs.json)
programs=($(echo $json | jq 'keys[]'))

for program in ${programs[@]}; do
	programName=${program//\"}
	echo $BOLD"INSTALLING $programName..."$ENDC

	pre_steps=`echo $json | jq ".$programName.pre_steps"`
	if [ "$pre_steps" != "null" ]; then
		execSteps "${pre_steps//\"}"
	fi

	repo=`echo $json | jq ".$programName.repo"`
	if [ "$repo" != "null" ]; then
		repo=${repo//\"}
		addRepo $repo
	fi

	version=`echo $json | jq ".$programName.version"`
	if [ "$version" != "null" ]; then
		package="$programName==${version//\"}"
	else
		package=$programName
	fi

	additional_packages=`echo $json | jq ".$programName.additional_packages"`
	if [ "$additional_packages" != "null" ]; then
		additional_packages="${additional_packages//\"}"
		additional_packages=$(echo $additional_packages | sed -e "s/\(\[\s\|\s\]\|,\)//g")
	else
		additional_packages=''
	fi

	installPackage $package $additional_packages

	post_steps=`echo $json | jq ".$programName.post_steps"`
	if [ "$post_steps" != "null" ]; then
		execSteps "${post_steps//\"}"
	fi
	echo
done
echo $BOLD$GREEN"DONE!"$ENDC

read -p "DO YOU WISH TO INSTALL CONFIGURATIONS TOO? [y/N]: " yn
case $yn in
	[Yy]* ) exec ./copyconfigs.sh; break;;
	* ) exit;;
esac