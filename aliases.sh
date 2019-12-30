command_exists () {
    type "$1" &> /dev/null ;
}


if command_exists codium; then
    alias code=codium
fi