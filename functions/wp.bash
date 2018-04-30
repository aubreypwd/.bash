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

###
 # New Plugin.
 #
 # E.g: new-plugin my-plugin "My Plugin"
 #
 # @since Monday, April 30, 2018
 ##
function new-plugin {

	if [ '--help' == "$1" ]; then
		echo "Usage: new-plugin [plugin-name] [Real Plugin Name]" && return;
	fi

	# $1 and $2 are required.
	if [ -z "$1" ]; then
		echo 'Sorry, you must supply a programmatic plugin name, e.g. my-plugin-name as the first parameter.' && return
	fi

	if [ -z "$2" ]; then
		echo 'Sorry, but you must supply a real plugin name e.g. My Plugin Name as the seconds parameter.' && return
	fi

	# Get the different versions of the plugin name.
	program_plugin_name="$1";
	real_plugin_name="$2";
	namespaced_program_plugin_name=$(php -r "echo str_replace( ' ', '', ucwords( str_replace( '-', ' ', '$program_plugin_name' ) ) );");

	# If a folder exists, bail.
	if [ -e "$program_plugin_name" ]; then
		echo "Sorry, but the folder $program_plugin_name already exists!" && return;
	fi

	# Clone the repo for new plugin and get into that folder.
	git clone https://github.com/aubreypwd/wp-plugin-boilerplate "./$program_plugin_name"
	cd "$program_plugin_name" || return

	# Rename the plugin file.
	mv "plugin-name.php" "$program_plugin_name.php"

	# Remove git stuffs.
	trash .git*

	# Do replacements :D:D:D:D.
	find ./ -type f -exec sed -i '' -e "s/YourPluginName/$namespaced_program_plugin_name/" {} \;
	find ./ -type f -exec sed -i '' -e "s/PluginName/$real_plugin_name/" {} \;
	find ./ -type f -exec sed -i '' -e "s/plugin-name/$program_plugin_name/" {} \;
	find ./ -type f -exec sed -i '' -e "s/YourCompanyName/WebDevStudios/" {} \;
	find ./ -type f -exec sed -i '' -e "s/your-company/webdevstudios/" {} \;
	find ./ -type f -exec sed -i '' -e "s/NEXT/1.0.0/" {} \;
	find ./ -type f -exec sed -i '' -e "s/Your Name/Aubrey Portwood <aubrey@webdevstudios.com>/" {} \;
	find ./ -type f -exec sed -i '' -e "s/example.com/webdevstudios.com/" {} \;

	# Get back to our folder.
	cd ..
}
