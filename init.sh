#!/bin/env bash

if [ ! -v HOME ]; then
	echo -e 'HOME is not set. Please set it first and run the script'
	exit 1
fi

ORIGIN=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
# some terminal control characters
RESET='\e[0m'
GREEN='\e[0;32m'
RED='\e[0;31m'
YELLOW='\e[0;33m'

check_bins() {
	tools=(xxd jq vim nvim curl sed cut tar zip grep bash zsh git keychain htop btop tmux python pnpm cargo firejail aa-status podman wg gsocket nmap)
	gui=(firefox code terminator alacritty obsidian thunderbird conky)
	
	echo -e "[#] Checking for tools and applications... (Only missing ones are reported)"
	for bin in ${tools[@]}; do
		if [ -x "$(command -v $bin)" ]; then
			#echo -e "${GREEN}[+] $bin: OK.${RESET}"
			continue
		else
			echo -e "${RED}[-] $bin: Not found in PATH${RESET}"
		fi
	done
	
	for bin in ${gui[@]}; do
		if [ -x "$(command -v $bin)" ]; then
			#echo -e "${GREEN}[+] $bin: OK.${RESET}"
			continue
		else
			echo -e "${RED}[-] $bin: Not found in PATH${RESET}"
		fi
	done
	echo -e "[#] Done with tools and application check."
}

base_env() {
	base_config=$(ls $ORIGIN/base)
	
	echo -e "[#] Checking and installing base config files..."
	for config in ${base_config[@]}; do
		if [ -v "OVERRIDE_CUR" ]; then
			ln -sLf "$ORIGIN/base/$config" "$HOME/.$config"
			echo -e "${GREEN}[+] $HOME/.$config has been FORCE installed.${RESET}"
		elif [ -f "$HOME/.$config" ] || [ -L "$HOME/.$config" ]; then
			echo -e "${YELLOW}[!] $HOME/.$config already exists. Set OVERRIDE_CUR=1 to force install.${RESET}"
		else
			ln -sL "$ORIGIN/base/$config" "$HOME/.$config"
			echo -e "${GREEN}[+] $HOME/.$config installed.${RESET}"
		fi
	done
	echo -e "[#] Done with base configs."

	if [ -v "INCLUDE_EXTRA" ]; then
		source $ORIGIN/extra.sh
		extra_env
	else
		echo "[#] Skipping extra configs. Set INCLUDE_EXTRA=1 to include the step."
	fi
}

init() {
	check_bins
	base_env

	echo -e "[#] Enjoy the new environment o7"
}

init
