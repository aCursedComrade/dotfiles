DOTFILES="$HOME/.dotfiles"
source $DOTFILES/profiles/funcs.sh
export -U XDG_DATA_DIRS="$XDG_DATA_DIRS:$HOME/.local/share"

# bash specific opts
if [ -v "BASH_VERSION" ]; then
    # include .bashrc
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi

    shopt -s histverify
    shopt -s histreedit
fi

if locale -a | grep -e "^en_US" &> /dev/null; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
else
    export LANG="C.UTF-8"
    export LC_ALL="C.UTF-8"
fi

# add user's private bin to PATH
if [ -d "$HOME/.local/bin" ]; then
    export -U PATH="$PATH:$HOME/.local/bin"
fi

# add cargo bin to PATH
if [ -d "$HOME/.cargo/bin" ]; then
    export -U PATH="$PATH:$HOME/.cargo/bin"
fi

# add pnpm bin to PATH
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export -U PATH="$PATH:$PNPM_HOME"
fi

# set EDITOR
if [ -x "$(command -v vim)" ]; then
    export EDITOR='vim'
else
    export EDITOR='nano'
fi
export TERM='xterm-256color'
export PAGER='less'
export LESS='-IRs'

# aliases
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
alias tb='nc termbin.com 9999'
alias grep='grep --color=auto'
alias ip='ip -c=always'
alias pn='pnpm'
alias nv='nvim'

# use keychain to load ssh keys
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain --ignore-missing --eval -q comrade)
fi

echo "Yet another day, we survive: $(logname)@$(cat /etc/hostname 2> /dev/null)"
