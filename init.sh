#!/bin/env bash
if [ ! -v "HOME" ]; then
    echo "[!] HOME is not set. Please set it first and run the script"
    exit 1
fi

# verify the dotfile config root
if [ ! -d "$HOME/.dotfiles" ] && [ ! -v "CONFIG_ROOT" ]; then
    echo "[!] CONFIG_ROOT or $HOME/.dotfiles/ is not set/found."
    echo "[!] Set the CONFIG_ROOT variable or move the dotfiles into $HOME/.dotfiles."
    exit 1
else
    if [ ! -v "CONFIG_ROOT" ]; then
        CONFIG_ROOT="$HOME/.dotfiles"
    fi
fi

# source our scripts
source $CONFIG_ROOT/src/util.sh
source $CONFIG_ROOT/src/base.sh
source $CONFIG_ROOT/src/extra.sh

menu() {
    # ascii art time
    echo -e "\n"
    echo -e "\t   \\  \\  \\"
    echo -e "\t   /  /  /"
    echo -e "\t   \\  \\  \\"
    echo -e "\t ___________"
    echo -e "\t |         |"
    echo -e "\t |         |"
    echo -e "\t |         |"
    echo -e "\t \\_________/"
    echo -e "\t ___________"
    # echo -e "\n"
    # echo -e "\t [#] Base configs: $base_config"
    # echo -e "\t [#] Extra configs: $extra_config"
    echo -e "\n"
    echo -e "\t Key \t\t Description"
    echo -e "\t --- \t\t -----------"
    echo -e "\t  1  \t\t ${RED}OVERRIDE${RESET} all configs"
    echo -e "\t  2  \t\t ${RED}OVERRIDE${RESET} only the BASE configs"
    echo -e "\t  3  \t\t ${RED}OVERRIDE${RESET} only the EXTRA configs"
    echo -e "\t --- \t\t -----------"
    echo -e "\t  q  \t\t Checks for installed applications"
    echo -e "\t  w  \t\t Install all missing configs"
    echo -e "\t  e  \t\t Install only the missing BASE configs"
    echo -e "\t  r  \t\t Install only the missing EXTRA configs"
    echo -e "\t  a  \t\t Add alacritty themes"
    echo -e "\t  n  \t\t Add nvim config"
    echo -e "\t --- \t\t -----------"
    echo -e "\t  h  \t\t Show this menu"
    echo -e "\t  c  \t\t Clear screen"
    echo -e "\t  x  \t\t Exit"
    echo -e "\n"
}

main() {
    clear
    menu

    while :
    do
        read -p "[#] Select an option (Press h to see the menu): " selection

        case $selection in
            1) 
                OVERRIDE_CUR=1
                base_env
                extra_env
                unset OVERRIDE_CUR
                ;;
            2) 
                OVERRIDE_CUR=1
                base_env
                unset OVERRIDE_CUR
                ;;
            3) 
                OVERRIDE_CUR=1
                extra_env
                unset OVERRIDE_CUR
                ;;
            q) check_bins ;;
            w) base_env; extra_env ;;
            e) base_env ;;
            r) extra_env ;;
            a) alacritty_themes ;;
            n) nvim_config ;;
            h) options ;;
            c) clear ;;
            x) break ;;
            *) continue
        esac
    done

    echo "[+] Enjoy the new environment o7"
}

main
