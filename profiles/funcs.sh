# to switch between python venv
pyvenv() {
    if [ -d "$HOME/.pyvenv" ]; then
        source "$HOME/.pyvenv/bin/activate"
    else
        echo "$HOME/.pyenv does not exist." >&2
        echo "Create a new venv with: python -m venv $HOME/.pyvenv" >&2
        return 1
    fi
}

# https://cjbarker.com/blog/creating-high-entropy-passwords-on-linux/
genpasswd() {
    if [ $# -eq 0 ]; then
        passwd=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()<>/?' < /dev/urandom | head -c 24; echo)
        echo "${passwd}"
    else
        # custom length support
        passwd=$(LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()<>/?' < /dev/urandom | head -c "$1"; echo)
        echo "${passwd}"
    fi
}

# https://transfer.sh/
transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguements speicified.\nUsage: \n transfer <file|directory>\n ... | transfer <file_name>" >&2
        return 1
    fi

    if tty -s; then
        file="$1"
        file_name=$(basename "$file")

        if [ ! -e "$file" ]; then
            echo "$file does not exist" >&2
            return 1
        fi

        if [ -d "$file" ]; then
            (zip -r -q - "$file") | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name.zip" | tee /dev/null; echo
        else
            cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null; echo
        fi
    else
        file_name="$1"
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null; echo
    fi
}

cheatsh() {
    [ $# -ne 0 ] && (curl -fsSL https://cht.sh/$1 | $PAGER)
}

