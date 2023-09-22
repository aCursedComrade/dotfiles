#!/bin/env bash

if [ ! -v HOME ]; then
	echo -e 'HOME is not set. Please set it first and run the script'
	exit 1
fi

# some terminal control characters
RESET='\e[0m'
GREEN='\e[0;32m'
RED='\e[0;31m'
YELLOW='\e[0;33m'

ORIGIN=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

echo -e "[#] Checking and installing dotfiles..."
if [ -f "$HOME/.profile" ] || [ -L "$HOME/.profile" ]; then
	echo -e "${YELLOW}[!] $HOME/.profile already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/shellrc" "$HOME/.profile"
	echo -e "${GREEN}[+] $HOME/.profile installed.${RESET}"
fi

if [ -f "$HOME/.zlogin" ] || [ -L "$HOME/.zlogin" ]; then
	echo -e "${YELLOW}[!] $HOME/.zlogin already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/shellrc" "$HOME/.zlogin"
	echo -e "${GREEN}[+] $HOME/.zlogin installed.${RESET}"
fi

if [ -v "SET_GIT" ];then
	if [ -f "$HOME/.gitconfig" ] || [ -L "$HOME/.gitconfig" ]; then
		echo -e "${YELLOW}[!] $HOME/.gitconfig already exists. Consider manually installing the config.${RESET}"
	else
		ln -s "$ORIGIN/gitconfig" "$HOME/.gitconfig"
		echo -e "${GREEN}[+] $HOME/.gitconfig installed.${RESET}"
	fi
fi
echo -e "[#] Done with dotfiles."

tools=(xxd jq vim nvim curl sed cut tar zip grep bash zsh git keychain htop btop tmux python pnpm cargo firejail aa-status podman wg gsocket nmap)
gui=(firefox code terminator alacritty obsidian thunderbird conky)

echo -e "[#] Checking for tools and applications... (Only missing ones are reported)"
for bin in ${tools[@]}; do
	if [ -x "$(command -v $bin)" ]; then
		#echo -e "${GREEN}$bin: OK.${RESET}"
		continue
	else
		echo -e "${RED}$bin: Not found in PATH${RESET}"
	fi
done

for bin in ${gui[@]}; do
	if [ -x "$(command -v $bin)" ]; then
		#echo -e "${GREEN}$bin: OK.${RESET}"
		continue
	else
		echo -e "${RED}$bin: Not found in PATH${RESET}"
	fi
done
echo -e "[#] Done with tools and application check."
echo -e "[#] Enjoy the new environment o7"
