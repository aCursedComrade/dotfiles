# system specific variables
if [ -f "$HOME/.envrc" ]; then
    source "$HOME/.envrc"
fi

export TERM='xterm-256color'
export EDITOR='vim'
export PAGER='less'
export LESS='-IRs'
export GPG_TTY=$(tty)

if locale -a | grep -e "^en_US" &> /dev/null; then
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
else
    export LANG="C.UTF-8"
    export LC_ALL="C.UTF-8"
fi

# add user's private bin to PATH
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# add cargo bin to PATH
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# add pnpm bin to PATH
if [ -d "$HOME/.local/share/pnpm" ]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    export PATH="$PNPM_HOME:$PATH"
fi

