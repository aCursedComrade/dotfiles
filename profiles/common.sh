DOTFILES="$HOME/.dotfiles"

source $DOTFILES/profiles/funcs.sh
if [ "$SHLVL" == 1 ]; then
    source $DOTFILES/profiles/env.sh
fi

if [ -x "$(command -v eza)" ]; then
    alias ll="eza -glb -s=type --icons=auto $@"
    alias la="eza -aglb -s=type --icons=auto $@"
    alias lt="eza -agT -s=type --icons=auto $@"
else
    alias ll="ls --group-directories-first --color -lhF $@"
    alias la="ls --group-directories-first --color -alhF $@"
    alias lt="ls --group-directories-first --color -RlhF $@"
fi

alias dotfiles="bash $DOTFILES/src/main.sh"
alias wtfismyip="curl myip.wtf/yaml"
alias grep="grep --color=auto $@"
alias tb="ncat termbin.com 9999"
alias ip="ip -c=always $@"
alias pn="pnpm"
alias nv="nvim"

#BOX="$(echo -n "${HOSTNAME:-$(cat /etc/hostname)}" | cut -d '.' -f 1)"
#echo "Yet another day, we survive: $USER@$BOX"

