#!/bin/bash

###
 # Edit commands that opens things in edits.
 #
 # @since 3/11/17 Move to it's own file from functions.bash.
 ##

###
 # My edit
 #
 # @since Friday, May 11, 2018
 ##
function edit {
	subl "$1"
}

###
 # Edits Sublime Text Snippets
 #
 # E.g: edit-snippets
 #
 # @since 4/5/16
 ##
function edit-snippets {
	file="$HOME/Library/Application Support/Sublime Text 3/Packages/User/Snippets"

	if [ -e "$file" ]; then
		edit "$file"
	else
		echo "Couldn't find $file"
	fi
}

###
 # Edit these .files.
 #
 # E.g. edit-files
 #
 # @since 12/1/16
 ##
function edit-files {
	if [ -s ~/.files ]; then
		edit ~/.files
	fi
}

###
 # Edit's this file.
 #
 # E.g: edit-bash
 #
 # @since 4/5/16
 # @since 12/15/16 Now it edits all the files in /bash.s
 ##
function edit-bash {
	file="$HOME/.bash";

	if [ -e "$file" ]; then
		edit "$file"
	else
		echo "Couldn't find $file"
	fi
}

###
 # Edits the /etc/hosts file.
 #
 # E.g: edit-hosts
 #
 # @since 4/5/16
 ##
function edit-hosts {
	file="/etc/hosts"

	if [ -e "$file" ]; then
		edit "$file"
	else
		echo "Couldn't find $file"
	fi
}
