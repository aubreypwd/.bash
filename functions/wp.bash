#!/bin/bash

###
 # WP Functions.
 #
 # @since 3/11/17 Move to it's own file from functions.bash.
 ##

###
 # Replace things in the Database.
 #
 # E.g.: wp-replace "youth.wdslab.com" "youth.dev".
 #
 # @since 1/17/17
 ##
function wp-replace {
	wp search-replace "$1" "$2" --network --all-tables
}

###
 # Watch debug.log
 #
 # @since 6/21/16
 ##
function wp-debug {
	if [ '--help' == "$1" ]; then
		echo "Usage: wp-debug [--reset]"
			return;
	fi

	if [ '--reset' == "$1" ]; then
		if [ -e ./debug.log ]; then

			# Delete the debug.log file first.
			trash ./debug.log

			# Create a new empty file.
			touch ./debug.log
		fi;
	fi

	if [ -e ./debug.log ]; then
		clear
		tail -n "$LINES" -f "debug.log"
	else
		echo "No debug.log found."
	fi
}

###
 # Clear and view debug.log.
 #
 # @since 6/21/16
 ##
function wp-debug-reset {
	if [ -e ./debug.log ]; then
		clear
		echo "============== debug.log cleared ==============" > debug.log
		wp-debug
	else
		echo "No debug.log found. :("
	fi
}

###
 # Applies a Trac ticket patch via a URL.
 #
 # E.g: trac-apply-patch <the url to the trac ticket>
 #
 # @since 4/5/16
 ##
function wp-trac-apply-patch {
	curl -k "$1" | patch -p0
}

###
 # Deploys a WordPress plugin to SVN
 #
 # E.g: wp-org-deploy plugin_file_with_header.php aubreypwd false
 #
 # @since 4/5/16
 ##
function wp-org-deploy {

	# Get the deploy script.
	wget https://raw.githubusercontent.com/aubreypwd/deploy-git-wordpress-org/master/deploy-git-wordpress-org.sh

	# Run the deploy command with your arguments.
	sh deploy-git-wordpress-org.sh "$1" "$2" "$3"

	# Cleanup, remove the deploy script.
	rm deploy-git-wordpress-org.sh
}


###
 # Get my custom wp debug script.
 #
 # @since 7/12/2017
 ##
function get-d {
	wget https://github.com/aubreypwd/.files/raw/master/wp/scripts/d.php
	echo "Downloaded https://github.com/aubreypwd/.files/raw/master/wp/scripts/d.php."
}

###
 # Tail the d.log file.
 #
 # @since 7/14/2017
 ##
function dlog {
	if [ '--help' == "$1" ]; then
		echo "Usage: dlog [--reset]"
			return;
	fi

	if [ '--reset' == "$1" ]; then
		if [ -e ./d.log ]; then

			# Delete the d.log file first.
			trash ./d.log

			# Create a new empty file.
			touch ./d.log
		fi;
	fi

	if [ -e ./d.log ]; then
		clear
		tail -n "$LINES" -f "d.log"
	else
		echo "No d.log found."
	fi
}
