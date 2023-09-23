#!/bin/env bash

extra_env() {
	base_config=$(ls $ORIGIN/extra)
	
	echo -e "[#] Checking and installing extra config files..."
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
	echo -e "[#] Done with extra configs."
}
