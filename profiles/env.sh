export ENV_SOURCED=1
#export TERM='xterm-256color'
export EDITOR='vim'
export PAGER='less'
export LESS='-IRs'
export GPG_TTY=$(tty)

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$PATH:$HOME/.cargo/bin"
fi

# use keychain to start ssh-agent and populate env
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain agent start --eval -q)
fi
