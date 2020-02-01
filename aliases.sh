command_exists () {
    type "$1" &> /dev/null ;
}


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
