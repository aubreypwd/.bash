#!/bin/bash

###
 # Functions.
 #
 # @since 12/1/16 Move to it's own file.
 ##

source ~/.bash/functions/git.bash   # Git stuff.
source ~/.bash/functions/wp.bash    # WP related stuff.
source ~/.bash/functions/misc.bash  # Misc stuff.
source ~/.bash/functions/edit.bash  # edit- command stuff.
source ~/.bash/functions/files.bash  # Files stuff.
source ~/.bash/functions/slack.bash  # Slack stuff.
source ~/.bash/functions/harvest.bash  # Harvest stuff.
source ~/.bash/functions/lbf.bash  # Local by Flywheel stuff.

###
 # Another easy way to exit.
 #
 # @since 5/13/16
 ##
function x {
	if ! [ '' = "$1" ]; then
		eval "$1";
		echo "Exiting in 3 seconds..."
		sleep 3
	fi

	exit;
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
