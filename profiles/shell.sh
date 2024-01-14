DOTFILES="$HOME/.dotfiles"
source $DOTFILES/profiles/funcs.sh

if [ -v "BASH_VERSION" ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='\u@\h \W \$ '
    else
        PS1='\u@\h \w \$ '
    fi
    source $DOTFILES/profiles/env.sh

    shopt -s histverify
    shopt -s histreedit
    shopt -s histappend
    shpot -s checkwinsize
    shopt -s globstar
fi

if [ -x "$(command -v eza)" ]; then
    alias ll='eza -gl -s type --icons $@'
    alias la='eza -agl -s type --icons $@'
    alias lt='eza -agT -s type --icons $@'
else
    alias ll="ls --color=auto -lhXF"
    alias la="ls --color=auto -AlhXF"
fi

alias dotfiles="bash $HOME/.dotfiles/init.sh"
alias wtfismyip='curl yaml.myip.wtf'
alias grep='grep --color=auto'
alias tb='ncat termbin.com 9999'
alias ip='ip -c=always'
alias pn='pnpm'
alias nv='nvim'

# use keychain to load ssh keys
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain --ignore-missing --eval -q comrade)
fi

echo "Yet another day, we survive: $(whoami 2> /dev/null)@$(hostname 2> /dev/null)"

