check_bins() {
    gui=(firefox vscodium terminator alacritty obsidian thunderbird flameshot okular motrix wireshark vlc tlpui feather imhex timeshift)
    tools=(xxd jq vim nvim curl tar zsh git keychain htop btop tmux firejail aa-status podman wg gsocket nmap ufw rclone tlp gpg mitmproxy gdb openvpn dog)
    langs=(rustc python pip pipx node java x86_64-w64-mingw32-gcc)

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

base_config=$(ls $CONFIG_ROOT/base)
base_env() {
    # vim backup dir
    mkdir -p $HOME/.vim/backup/

    for config in ${base_config[@]}; do
        if [ -v "OVERRIDE_CUR" ]; then
            if [ -f "$HOME/.$config" ]; then
                mv "$HOME/.$config" "$HOME/.$config.bak"
            fi

            ln -sLf "$CONFIG_ROOT/base/$config" "$HOME/.$config"
            echo -e "${YELLOW}[+] $HOME/.$config has been moved and replaced with ours.${RESET}"
        elif [ -f "$HOME/.$config" ] || [ -L "$HOME/.$config" ]; then
            echo -e "${YELLOW}[!] $HOME/.$config already exists. Set OVERRIDE_CUR=1 to force install.${RESET}"
        else
            ln -sL "$CONFIG_ROOT/base/$config" "$HOME/.$config"
            echo -e "${GREEN}[+] $HOME/.$config installed.${RESET}"
        fi
    done
    echo "[#] Done with BASE configs."
}
