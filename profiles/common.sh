DOTFILES="$HOME/.dotfiles"
source $DOTFILES/profiles/funcs.sh
if [ ! -v "ENV_SOURCED" ]; then
    source $DOTFILES/profiles/env.sh
fi

if [ -x "$(command -v eza)" ]; then
    alias ll="eza -gl -s filename --icons auto $@"
    alias la="eza -agl -s filename --icons auto $@"
    alias lt="eza -agT -s filename --icons auto $@"
else
    alias ll="ls --color=auto -lhF $@"
    alias la="ls --color=auto -AlhF $@"
    alias lt="echo 'No tree view for you :('"
fi

alias dotfiles="bash $DOTFILES/init.sh"
alias wtfismyip="curl yaml.myip.wtf"
alias grep="grep --color=auto $@"
alias tb="ncat termbin.com 9999"
alias ip="ip -c=always $@"
alias pn="pnpm"
alias nv="nvim"

BOX="$(echo -n "${HOSTNAME:-$(cat /etc/hostname)}" | cut -d '.' -f 1)"
echo "Yet another day, we survive: $USER@$BOX"

