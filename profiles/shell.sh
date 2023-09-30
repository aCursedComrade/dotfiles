# are we running bash
if [ -v "BASH_VERSION" ]; then
    # include .bashrc
    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi

if locale -a | grep -e "^en_US" &> /dev/null; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
else
    export LANG="C.UTF-8"
    export LC_ALL="C.UTF-8"
fi
export TERM='xterm-256color'
export PAGER='less'
export LESS='-IRs'

# add user's private bin to PATH
if [ -d "$HOME/.local/bin" ]; then
    export -U PATH="$HOME/.local/bin:$PATH"
fi

# add cargo bin to PATH
if [ -d "$HOME/.cargo/bin" ]; then
    export -U PATH="$HOME/.cargo/bin:$PATH"
fi

# add pnpm bin to PATH
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export -U PATH="$PNPM_HOME:$PATH"
fi

# set EDITOR
if [ -x "$(command -v nvim)" ]; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# use keychain to load ssh keys
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain --ignore-missing --eval -q comrade)
else
    echo "[!] keychain not found in the system"
fi

# to switch between python venv
pyvenv() {
    if [ -d "$HOME/.pyvenv" ]; then
        source "$HOME/.pyvenv/bin/activate"
    else
        echo "$HOME/.pyenv does not exist."
        echo "Create a new venv with: python -m venv $HOME/.pyvenv"
    fi
}

# aliases
if [ -x "$(command -v eza)" ]; then
    alias ll='eza -gl -s type --icons'
    alias la='eza -agl -s type --icons'
    alias lt='eza -agT -s type --icons'
else
    alias ll="ls --color=auto -lhXF"
    alias la="ls --color=auto -AlhXF"
fi
alias wtfismyip='curl yaml.myip.wtf'
alias tb='nc termbin.com 9999'
alias grep='grep --color=auto'
alias ip='ip -c=always'
alias pn='pnpm'
alias nv='nvim'

echo "Yet another day, we survive: $(whoami 2> /dev/null)@$(hostname 2> /dev/null)"
