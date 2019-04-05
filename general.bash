#!/bin/bash

# Set CLICOLOR if function you want Ansi Colors in iTerm2
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM="xterm-256color";

#wp-cli
source "$HOME/.bash/wp-completion.bash"

# Default editor
export EDITOR="vim +startinsert"

# Git Aware!
export GITAWAREPROMPT="$HOME/.bash/git-aware-prompt"
source "$GITAWAREPROMPT/main.sh";

# .bash Power prompt.
#source "$HOME/.bash/.bash-powerline.sh" 2> /dev/null

# Git completion.
source "$HOME/.bash/git-completion.bash"

# Homebrew PHP.
export PATH="/usr/local/sbin:$PATH"

# Do SVN commits like Git.
export SVN_EDITOR="vim +startinsert"

PS1="\n$FG_BASE03>$RESET "
