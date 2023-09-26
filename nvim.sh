#!/bin/env bash

nvim_config() {
    # nvim stuff goes here
    if [ -v "OVERRIDE_CUR" ]; then
        ln -sLf "$CONFIG_ROOT/nvim" "$HOME/.config/nvim"
        echo -e "${GREEN}[+] $HOME/.config/nvim has been FORCE installed.${RESET}"
    elif [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        echo -e "${YELLOW}[!] $HOME/.config/nvim already exists. Set OVERRIDE_CUR=1 to force install.${RESET}"
    else
        ln -sL "$CONFIG_ROOT/nvim" "$HOME/.config/nvim"
        echo -e "${GREEN}[+] $HOME/.config/nvim installed.${RESET}"
    fi
}

nvim_config
