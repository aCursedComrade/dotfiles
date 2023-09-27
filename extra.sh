# extra configurations
extra_config=$(ls $CONFIG_ROOT/extra)
extra_env() {
    for config in ${extra_config[@]}; do
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
    echo "[#] Done with EXTRA configs."
}

# link nvim config folder
nvim_config() {
    if [ -d "$HOME/.config/nvim" ] || [ -L "$HOME/.config/nvim" ]; then
        echo -ne "${YELLOW}[!] $HOME/.config/nvim already exists. Override it?${RESET} "
        read option

        case $option in
            y|Y)
                ln -sLf "$CONFIG_ROOT/nvim" "$HOME/.config/nvim"
                echo -e "${GREEN}[+] $HOME/.config/nvim has been FORCE installed.${RESET}"
                ;;
            *) echo -e "${YELLOW}[!] Skipping nvim config.${RESET}"
        esac

    else
        ln -sL "$CONFIG_ROOT/nvim" "$HOME/.config/nvim"
        echo -e "${GREEN}[+] $HOME/.config/nvim installed.${RESET}"
    fi
}

# install alacritty themes
alacritty_themes() {
    mkdir -p $HOME/.config/alacritty

    if [ -d "$HOME/.config/alacritty/themes" ] || [ -L "$HOME/.config/alacritty/themes" ]; then
        echo -ne "${YELLOW}[!] $HOME/.config/alacritty/themes/ already exists. Override it?${RESET} "
        read option

        case $option in
            y|Y)
                rm -fr "$HOME/.config/alacritty/themes"
                git clone https://github.com/alacritty/alacritty-theme "$HOME/.config/alacritty/themes"
                ;;
            *) echo -e "${YELLOW}[!] Skipping nvim config.${RESET}"
        esac
    else
        git clone https://github.com/alacritty/alacritty-theme "$HOME/.config/alacritty/themes"
    fi
    echo "[#] Done with alacritty themes."
}
