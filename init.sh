#!/bin/env bash

if [ ! -v "HOME" ]; then
    echo "HOME is not set. Please set it first and run the script"
    exit 1
fi

# verify the dotfile config root
if [ ! -d "$HOME/.dotfiles" ] && [ ! -v "CONFIG_ROOT" ]; then
    echo "CONFIG_ROOT or $HOME/.dotfiles/ is not set/found. Set or create either one to proceed."
    exit 1
else
    if [ ! -v "CONFIG_ROOT" ]; then
        CONFIG_ROOT="$HOME/.dotfiles"
    fi
fi

# source util script
source $CONFIG_ROOT/util.sh

check_bins() {
    tools=(xxd jq vim nvim curl sed cut tar zip grep bash zsh git keychain htop btop tmux python pnpm cargo firejail aa-status podman wg gsocket nmap)
    gui=(firefox code terminator alacritty obsidian thunderbird conky)

    echo "[#] Checking for tools and applications... (Only missing ones are reported)"
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
    echo "[#] Done with tools and application check."
}

base_env() {
    base_config=$(ls $CONFIG_ROOT/base)

    echo "[#] Checking and installing base config files..."
    for config in ${base_config[@]}; do
        if [ -v "OVERRIDE_CUR" ]; then
            ln -sLf "$CONFIG_ROOT/base/$config" "$HOME/.$config"
            echo -e "${GREEN}[+] $HOME/.$config has been FORCE installed.${RESET}"
        elif [ -f "$HOME/.$config" ] || [ -L "$HOME/.$config" ]; then
            echo -e "${YELLOW}[!] $HOME/.$config already exists. Set OVERRIDE_CUR=1 to force install.${RESET}"
        else
            ln -sL "$CONFIG_ROOT/base/$config" "$HOME/.$config"
            echo -e "${GREEN}[+] $HOME/.$config installed.${RESET}"
        fi
    done
    echo "[#] Done with base configs."

    # extra configs
    if [ -v "INCLUDE_EXTRA" ]; then
        source $CONFIG_ROOT/extra.sh
    else
        echo "[#] Skipping extra configs. Set INCLUDE_EXTRA=1 to include the step."
    fi

    # fancy nvim config
    if [ -v "INCLUDE_NVIM" ]; then
        source $CONFIG_ROOT/nvim.sh
    else
        echo "[#] Skipping nvim config. Set INCLUDE_NVIM=1 to include the step."
    fi
}

init() {
    mkdir -p $HOME/.vim/backup/
    mkdir -p $HOME/.config/

    check_bins
    base_env

    echo "[#] Enjoy the new system o7"
}

init
