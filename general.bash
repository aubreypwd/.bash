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
source "$HOME/.bash/.bash-powerline.sh" 2> /dev/null

# Git completion.
source "$HOME/.bash/git-completion.bash"

# Homebrew PHP.
export PATH="/usr/local/sbin:$PATH"

# Do SVN commits like Git.
export SVN_EDITOR="vim +startinsert"

PS1="\n$FG_BASE03>$RESET "

###
 # A growing list of things this setup requires.
 #
 # @since Tuesday, May 21, 2019
 #
 # E.g: bash-install
 ##
function bash-install {
	brew install aria2c
	brew install fzf
	brew install php@7.1
	brew install php@7.2
	brew install php@7.3
	brew install ffmpeg
	brew install ack
	brew install gawk
	brew install git
	brew install node
	brew install slack-cli
	brew install wp-cli
	brew install trash
	brew install subversion
	brew install ranger

	sudo npm install -g nativefier
}
