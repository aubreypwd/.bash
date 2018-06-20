#!/bin/bash

###
 # Functions.
 #
 # @since 12/1/16 Move to it's own file.
 ##

source ~/Bash/functions/git.bash   # Git stuff.
source ~/Bash/functions/wp.bash    # WP related stuff.
source ~/Bash/functions/misc.bash  # Misc stuff.
source ~/Bash/functions/edit.bash  # edit- command stuff.
source ~/Bash/functions/files.bash  # Files stuff.
source ~/Bash/functions/slack.bash  # Slack stuff.
source ~/Bash/functions/harvest.bash  # Harvest stuff.

###
 # Another easy way to exit.
 #
 # @since 5/13/16
 ##
function x {
	exit
}

###
 # Re-sources this bash file.
 #
 # E.g: reload-bash
 #
 # @since 4/5/16
 ##
function reload {
	file="$HOME/.bash_profile"

	if [ -e "$file" ]; then
		source "$file" > /dev/null
		echo "Reloaded $file."
	else
		echo "Couldn't find $file."
	fi
}
