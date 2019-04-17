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

	if ! [ -e ./debug.log ]; then
		touch "debug.log"
	fi

	clear
	tail -n "$LINES" -f "debug.log"
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
 # E.g: apply-patch <the url to the trac ticket>
 #
 # @since 4/5/16
 ##
function apply-patch {
	curl -k "$1" | patch -p0
}

###
 # Make a patch
 #
 # E.g: make-patch 40333
 #
 # @since Monday, April 1, 2019
 ##
function make-patch {
	git diff --no-prefix master..HEAD > "$1".patch
}

###
 # An easy way to run wp search-replace.
 #
 # E.g: wpreplaced "example.com" "example.test" --url="example.com"
 #
 # @since Wednesday, April 17, 2019
 ##
function wpreplaced {
	wp search-replace "$1" "$2" --network --all-tables --url="$1"
}

###
 # A easy way to replace anything using wp search-replace.
 #
 # E.g: wpreplace "foo" "bar"
 #
 # @since Wednesday, April 17, 2019
 ##
function wpreplace {
	wp search-replace "$1" "$2" --network --all-tables "$3" "$4" "$5" "$6"
}


