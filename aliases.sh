#!/bin/bash

command_exists () {
    type "$1" &> /dev/null ;
}

# safety nets
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
# confirmation
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# vscodium === vscode
if command_exists codium; then
    alias code=codium
fi

if command_exists docker; then

    if ! command_exists node; then
        nodecontainer="node:12.14.0"
        function npml() { docker run -v $(pwd):/app/:rw -w /app -it $nodecontainer /bin/bash -c "npm $@"; }
        function nodel() { docker run -v $(pwd):/app/:rw -w /app -it $nodecontainer /bin/bash -c "node $@"; }
        alias npm=npml
        alias node=nodel
    fi
fi
