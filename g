#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n'

# bare minimum command checks function
chk_cmd() {
    echo "checking bare minimum command functionality..."
    if ! command -v pushd &> /dev/null
    then
        echo "pushd does not exist, install it and then rerun this script! exiting."
        exit
    elif ! command -v curl &> /dev/null
    then
        echo "curl does not exist, install it and then rerun this script! exiting."
        exit
    elif ! command -v wget &> /dev/null
    then
        echo "wget does not exist, install it and then rerun this script! exiting."
        exit
    elif ! command -v unzip &> /dev/null
    then
        echo "unzip does not exist, install it and then rerun this script! exiting."
        exit
    fi
}

chk_cmd

B7E_HOME="$HOME/.b7e"
USAGE_D="$B7E_HOME/usages"
DLURL="https://github.com/heerdyes/bashguide/archive/refs/heads/main.zip"

setup_b7e() {
    echo -e "entering setup\ngoing to install bashguide on your system..."
    echo "creating ~/tmp and entering it..."
    TMPDIR="$HOME/tmp"
    mkdir $TMPDIR && pushd $TMPDIR
    wget $DLURL
    unzip main.zip
    cd bashguide-main
    if [ ! -d "$HOME/.local/bin" ]
    then
        echo "creating ~/.local/bin"
        mkdir -p "$HOME/.local/bin"
    fi
    if echo ":$PATH:" | grep ":$HOME/.local/bin"
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
    mkdir -p "$B7E_HOME"
    echo "copying files..."
    cp -r usages $B7E_HOME
    cp -r lang $B7E_HOME
    cp LICENSE $B7E_HOME
    cp README.md $B7E_HOME
    cd ..
    popd
    echo "removing temporary files..."
    rm -r $TMPDIR
    echo "exiting setup. done!"
    exit
}

remove_b7e() {
    echo "removing $B7E_HOME dir"
    rm -r "$B7E_HOME"
    echo "removing the script from ~/.local/bin"
    rm "$HOME/.local/bin/g"
    exit
}

clear
echo -e "bashguide - version 0.1"

if [ ! -d "$B7E_HOME" ]
then
    setup_b7e
fi

if [[ $# -eq 0 ]]
then
    while true
    do
        echo -e "\n\n----------- Topics -----------\n"
        echo "1. FS   - file system"
        echo "2. SH   - using the shell"
        echo "3. FLTR - filters"
        echo "4. PROG - shell programming"
        echo "5. INST - help with installing tools"
        echo "U. GOODBYE  - uninstall bashguide!"
        echo "q. QUIT - quit this program"
        echo -n "-> selection: "
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
        elif [ "$uch" == "5" ]
        then
            clear
            echo "# ---- INST ---- #"
            cat "$USAGE_D/inst"
        elif [ "$uch" == "U" ]
        then
            clear
            echo "# ---- UNINSTALL ---- #"
            remove_b7e
        elif [ "$uch" == "q" ]
        then
            echo "bye!"
            break
        else
            echo "no such option! exiting..."
            break
        fi
    done
elif [[ $# -eq 1 ]]
then
    echo -e "\n$1 examples:\n"
    grep -nr "$USAGE_D" -e "$1" | sed 's/^.*://'
else
    echo "unsupported number of arguments!"
    echo "exiting."
fi

