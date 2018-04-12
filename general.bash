#!/bin/bash

# Set CLICOLOR if function you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM="xterm-256color";

#wp-cli
source "$HOME/Bash/wp-completion.bash"

# Default editor
export EDITOR="vim +startinsert"

# Git Aware!
export GITAWAREPROMPT="$HOME/Bash/git-aware-prompt"
source "$GITAWAREPROMPT/main.sh";

# Bash Power prompt.
source "$HOME/Bash/.bash-powerline.sh" 2> /dev/null

# Git completion.
source "$HOME/Bash/git-completion.bash"

# Homebrew PHP.
export PATH="/usr/local/sbin:$PATH"

# Do SVN commits like Git.
export SVN_EDITOR="vim +startinsert"
