# checks for installed applcations
check_bins() {
    gui=(firefox code terminator alacritty obsidian thunderbird conky flameshot okular motrix wireshark vlc tlpui feather imhex timeshift)
    tools=(xxd jq vim nvim curl tar zsh git keychain htop btop tmux firejail aa-status podman wg gsocket nmap ufw rclone tlp gpg mitmproxy gdb openvpn dog)
    langs=(rustc python node java)

    lists=(tools langs gui)

    for list in ${lists[@]}; do
        eval 'bins=("${'$list'[@]}")'
        for bin in ${bins[@]}; do
            if [ -x "$(command -v $bin)" ]; then
                echo -e "${GREEN}[+] $bin: OK.${RESET}"
            else
                echo -e "${RED}[-] $bin: Not found in PATH${RESET}"
            fi
        done
    done

    echo "[#] Done with tools and application check."
}

# bare minimum config for a *nix envronment
base_config=$(ls $CONFIG_ROOT/base)
base_env() {
    mkdir -p $HOME/.vim/backup/

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
    echo "[#] Done with BASE configs."
}
