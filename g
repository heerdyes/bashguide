#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n'

B7E_HOME="$HOME/.b7e"
USAGE_D="$B7E_HOME/usages"

clear
echo -e "bashguide - version 0.1"

if [ ! -d "$B7E_HOME" ]
then
    echo -e "entering setup\ngoing to install bashguide on your system..."
    echo "creating ~/tmp and entering it..."
    mkdir "$HOME/tmp" && pushd "$HOME/tmp"
    wget https://raw.githubusercontent.com/heerdyes/bashguide/main/g
    if [ ! -d "$HOME/.local/bin" ]
    then
        echo "creating ~/.local/bin"
        mkdir -p "$HOME/.local/bin"
    fi
    if echo ":$PATH:" | grep ':$HOME/.local/bin'
    then
        echo "~/.local/bin already present on path. proceeding..."
    else
        echo "appending to .bashrc"
        echo -e "\n# bashguide config\nexport PATH=\"\$PATH:\$HOME/.local/bin\"" >> ~/.bashrc
        echo "updating PATH var for the current session..."
        export PATH="$PATH:$HOME/.local/bin"
    fi
    echo "updating g file permissions..."
    chmod +x g
    echo "going to copy file into dir: ~/.local/bin"
    cp g "$HOME/.local/bin"
    echo "creating bashguide home dir: $B7E_HOME"
    mkdir -p "$USAGE_D"
    echo "downloading usage files..."
    wget https://raw.githubusercontent.com/heerdyes/bashguide/main/usages/fltr
    wget https://raw.githubusercontent.com/heerdyes/bashguide/main/usages/fs
    wget https://raw.githubusercontent.com/heerdyes/bashguide/main/usages/prog
    wget https://raw.githubusercontent.com/heerdyes/bashguide/main/usages/sh
    echo "copying them to $USAGE_D"
    cp fltr "$USAGE_D"
    cp fs "$USAGE_D"
    cp prog "$USAGE_D"
    cp sh "$USAGE_D"
    popd
    echo "removing temporary files..."
    rm -r "$HOME/tmp"
    echo "exiting setup. done!"
    exit
fi

while true
do
    echo -e "\n\n----------- Topics -----------\n"
    echo "1. FS   - file system"
    echo "2. SH   - using the shell"
    echo "3. FLTR - filters"
    echo "4. PROG - shell programming"
    echo -n "-> select topic [1-4]: "
    read uch
    
    if [ "$uch" == "1" ]
    then
        clear
        echo "# ---- FS ---- #"
        cat "$USAGE_D/fs"
    elif [ "$uch" == "2" ]
    then
        clear
        echo "# ---- SH ---- #"
        cat "$USAGE_D/sh"
    elif [ "$uch" == "3" ]
    then
        clear
        echo "# ---- FLTR ---- #"
        cat "$USAGE_D/fltr"
    elif [ "$uch" == "4" ]
    then
        clear
        echo "# ---- PROG ---- #"
        cat "$USAGE_D/prog"
    else
        echo "no such option! exiting..."
        break
    fi
done
