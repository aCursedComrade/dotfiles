export ENV_SOURCED=1
#export TERM='xterm-256color'
export EDITOR='vim'
export PAGER='less'
export LESS='-IRs'
export GPG_TTY=$(tty)

# set basic locale if it doesnt exist
#if [ ! -v "LANG" ]; then
#    export LANG="C.UTF-8"
#    #export LC_ALL="C.UTF-8"
#    #export LANGUAGE="C.UTF-8"
#fi

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

#if [ -d "$HOME/.local/lib" ]; then
#    export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
#fi

# use keychain to start ssh-agent and populate env
if [ -x "$(command -v keychain)" ]; then
    eval $(keychain --ignore-missing --eval -q comrade)
fi

# user specific variables for this instance
if [ -f "$HOME/.envrc" ]; then
    source "$HOME/.envrc"
fi

