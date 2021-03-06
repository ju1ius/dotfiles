alias sudo="sudo -E"
alias ll="ls -lah"
##########
# Git
##########
alias gl="git log --oneline --decorate --graph"
alias lg="lazygit"
# Runs a one off git server from the current repository
# Then other can: `git clone git://your.ip.addr/ repo-name`
# or git pull `git://your.ip.addr/ branchname` to do a fetch and merge at once
# Note: The default git port is 9418
# https://gist.github.com/RichardBronosky/9af3b9796d7423cd0e8e1d419fcea9fc
alias git-serve="git daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/"

# docker-compose
alias dc="docker-compose"
alias dcb="COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build"
alias dcx="docker-compose exec"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dcl="docker-compose logs"

# Enable XDebug from command-line
alias php-debug="php -e -d zend_extension=xdebug.so"

# aliases for the kitty terminal emulator
alias kitcat="kitty +kitten icat"
alias kiff="kitty +kitten diff"
