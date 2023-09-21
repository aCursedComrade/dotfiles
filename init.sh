#!env sh

if [ ! -v HOME ]; then
	echo 'HOME is not set. Please set it first and run the script'
	exit 1
fi

alias echo='echo -e'

# some terminal control characters
RESET='\e[0m'
GREEN='\e[0;32m'
RED='\e[0;31m'
YELLOW='\e[0;33m'

ORIGIN=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

echo "[#] Checking and installing dotfiles..."
if [ -f "$HOME/.profile" ] || [ -L "$HOME/.profile" ]; then
	echo "${YELLOW}[!] $HOME/.profile already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/shellrc" "$HOME/.profile"
	echo "${GREEN}[+] $HOME/.profile installed.${RESET}"
fi

if [ -f "$HOME/.zlogin" ] || [ -L "$HOME/.zlogin" ]; then
	echo "${YELLOW}[!] $HOME/.zlogin already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/shellrc" "$HOME/.zlogin"
	echo "${GREEN}[+] $HOME/.zlogin installed.${RESET}"
fi

if [ -f "$HOME/.gitconfig" ] || [ -L "$HOME/.gitconfig" ]; then
	echo "${YELLOW}[!] $HOME/.gitconfig already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/gitconfig" "$HOME/.gitconfig"
	echo "${GREEN}[+] $HOME/.gitconfig installed.${RESET}"
fi

if [ -f "$HOME/.tmux.conf" ] || [ -L "$HOME/.tmux.conf" ]; then
	echo "${YELLOW}[!] $HOME/.tmux.conf already exists. Consider manually installing the config.${RESET}"
else
	ln -s "$ORIGIN/tmux.conf" "$HOME/.tmux.conf"
	echo "${GREEN}[+] $HOME/.tmux.conf installed.${RESET}"
fi
echo "[#] Done with dotfiles."

tools=(xxd jq vim nvim curl sed cut tar zip grep bash zsh git keychain htop btop tmux python pnpm cargo firejail aa-status podman wg gsocket nmap)
gui=(firefox code terminator obsidian thunderbird conky)

echo "[#] Checking for general tools..."
for bin in ${tools[@]}; do
	if [ -x "$(command -v $bin)" ]; then
		echo "${GREEN}$bin: OK.${RESET}"
	else
		echo "${RED}$bin: Not found in PATH${RESET}"
	fi
done

echo "[#] Checking for GUI programs..."
for bin in ${gui[@]}; do
	if [ -x "$(command -v $bin)" ]; then
		echo "${GREEN}$bin: OK.${RESET}"
	else
		echo "${RED}$bin: Not found in PATH${RESET}"
	fi
done
echo "[#] Done with tools and application check."
