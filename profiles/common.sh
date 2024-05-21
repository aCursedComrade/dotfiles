DOTFILES="$HOME/.dotfiles"
source $DOTFILES/profiles/funcs.sh
source $DOTFILES/profiles/env.sh

if [ -x "$(command -v eza)" ]; then
    alias ll="eza -gl -s type --icons $@"
    alias la="eza -agl -s type --icons $@"
    alias lt="eza -agT -s type --icons $@"
else
    alias ll="ls --color=auto -lhXF $@"
    alias la="ls --color=auto -AlhXF $@"
    alias lt="echo 'No tree view for you :('"
fi

alias dotfiles="bash $DOTFILES/init.sh"
alias wtfismyip="curl yaml.myip.wtf"
alias grep="grep --color=auto"
alias tb="ncat termbin.com 9999"
alias ip="ip -c=always"
alias pn="pnpm"
alias nv="nvim"

# use keychain to load ssh keys
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain --ignore-missing --eval -q comrade)
fi

BOX="$(echo -n "${HOSTNAME:-$(cat /etc/hostname)}" | cut -d '.' -f 1)"
echo "Yet another day, we survive: $USER@$BOX"

