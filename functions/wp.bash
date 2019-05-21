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
 # Applies a Trac ticket patch via a URL.
 #
 # E.g: apply-patch <the url to the trac ticket>
 #
 # @since 4/5/16
 ##
function wp-apply-patch {
	curl -k "$1" | patch -p0
}

###
 # Make a patch
 #
 # E.g: make-patch 40333
 #
 # @since Monday, April 1, 2019
 ##
function wp-make-patch {
	git diff --no-prefix master..HEAD > "$1".patch
}

###
 # A easy way to replace anything using wp search-replace.
 #
 # E.g: wpreplace "foo" "bar"
 #
 # @since Wednesday, April 17, 2019
 ##
function wp-db-replace {
	echo "Replacing $1 with $2 in all tables..." &&
		wp search-replace "$1" "$2" --all-tables

	if [ '--dbpass' == "$3" ]; then
		wp-db-pass
	fi
}

###
 # Easy way to set all user's passwords to `password`.
 #
 # E.g: db-pass
 #
 # @since Wednesday, April 17, 2019
 ##
function wp-db-pass {
	echo "Changing all users' passwords to 'password'..." &&
		wp db query "UPDATE wp_users SET user_pass = '5f4dcc3b5aa765d61d8327deb882cf99';"
}

###
 # Export wp db export into a .gz file.
 #
 # @since Tuesday, May 21, 2019
 #
 # E.g: wp-export
 ##
function wp-export {
	sqlfile=$(wp db export --porcelain)
	gzip "$sqlfile"
}

###
 # Run wp db import on a .gz file.
 #
 # @since Tuesday, May 21, 2019
 #
 # E.g: wp-import "$file"
 ##
function wp-import {
	echo "Extracting $1..."
	gunzip "$1"

	noext=$(echo "$1" | cut -f 1 -d '.')
	sqlfile="$noext.sql"

	echo "Importing $sqlfile..."
	wp db import "$sqlfile"

	echo "Re-compressing $sqlfile > $1"
	gzip "$sqlfile"
}
