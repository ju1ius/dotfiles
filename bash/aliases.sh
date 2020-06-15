alias sudo="sudo -E"
alias ll="ls -lah"
##########
# Git
##########
alias gl="git log --oneline --decorate --graph"
# Runs a one off git server from the current repository
# Then other can: `git clone git://your.ip.addr/ repo-name`
# or git pull `git://your.ip.addr/ branchname` to do a fetch and merge at once
# Note: The default git port is 9418
# https://gist.github.com/RichardBronosky/9af3b9796d7423cd0e8e1d419fcea9fc
alias git-serve="git daemon --verbose --export-all --base-path=.git --reuseaddr --strict-paths .git/"

alias dcmp="docker-compose"

# Enable XDebug from command-line
alias php-debug="php -e -d zend_extension=xdebug.so"
