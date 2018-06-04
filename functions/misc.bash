#!/bin/bash

###
 # Misc Functions.
 #
 # @since 3/11/17 Move to it's own file from functions.bash.
 ##

###
 # Get kint.php from Github.
 #
 # @since 6/21/17
 ##
function get-kint() {
	if [ -e "kint.php" ]; then
		trash kint.php # Trash the existing one.
	fi

	# Get a new one.
	wget https://raw.githubusercontent.com/kint-php/kint/master/build/kint.php
}

###
 # Run ctags.
 #
 # @since 3/27/2017
 ##
function tags {
	echo 'Running ctags -R...'
	ctags -R --exclude=".git" --exclude="node_modules" --exclude="*.min*" &> /dev/null
}

###
 # Opens a new Safari instance.
 #
 # @since 4/5/16
 ##
function new-safari {
	open -n -a "Safari"
}

###
 # Remove any missing files from the repo.
 #
 # @since 2/11/17
 ##
function svn-remove {
	svn status | grep '^!' | awk '{print $2}' | xargs svn rm --force
}

###
 # Add any new files to the repo.
 #
 # @since 8/19/17
 ##
function svn-add {
	svn status | grep '^\?' | awk '{print $2}' | xargs svn add --force
}

###
 # Reset a SVN repo.
 #
 # @since 8/20/17
 ##
function svn-reset {
	svn revert --recursive .
}

###
 # Syncs trunk with a tag.
 #
 # @since 8/20/17
 ##
function svn-tag {
	if [ -n "$1" ]; then
		if [ '--help' == "$1" ]; then
			echo "Copies content from tags/$1 to trunk/"
			echo "Usage: svn-tag [+string: The tag, e.g. 1.0]"
			return;
		fi

		if [ -e "tags/$1" ]; then
			svn rm "tags/$1" --force
		fi

		svn cp trunk "tags/$1"
		svn-addremove
		svn status
	else
		svn-tag --help
	fi
}

###
 # Syncs a tag with trunk.
 #
 # @since 8/20/17
 ##
function svn-trunk {
	if [ -n "$1" ]; then
		if [ '--help' == "$1" ]; then
			echo "Syncs content from tags/$1 to trunk/"
			echo "Usage: public [+string: The project folder in ~/Local Sites.]"
			return;
		fi

		if [ -e "tags/$1" ]; then
			svn rm trunk --force
			svn cp "tags/$1" trunk
			svn-addremove
		fi
	else
		svn-sync --help
	fi
}

###
 # Add any new files, remove any deleted files from the repo.
 #
 # @since 8/19/17
 ##
function svn-addremove {
	svn-add
	svn-remove
}

###
 # Flushes DNS Cache.
 #
 # E.g.: dns-flush
 #
 # @since 4/5/16
 ##
function dns-flush {
	sudo dscacheutil -flushcache && killall -HUP mDNSResponder
}

###
 # Sudo PHP.
 #
 # E.g.: sphp script.php arg1 arg2
 ##
function sphp {
	sudo php "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
}

###
 # Create a native app from a website.
 #
 # @since 4/5/16
 #
 # E.g.: native "HipChat" "http://hipchat.com"
 ##
function app {

	echo "Creating $1 from $2..."

	# Create the native webapp...
	nativefier -n "$1" -o --insecure "$2" --flash "$3" "$4" "$5" "$6" "$7"

	echo "Cleaning up..."

	# Move the .app it creates and clean up...
	currentdir="$(pwd)"
	app="$1"
	appdir="$currentdir/$app-darwin-x64"

	if [ ! -e "$appdir" ]; then
		echo "Can't find $appdir"
		return
	fi

	# If there's already an app, delete it.
	if [ -e "$HOME/Applications/$app.app" ]; then
		echo "Deleting previous $HOME/Applications/$app.app..."
		trash "$HOME/Applications/$app.app"
	fi

	# Copy the built app to Applications folder.
	cd "$appdir" || return
	cp -Rfa "$app.app" "$HOME/Applications/$app.app"

	# Go back and remove the build dir.
	cd "$currentdir" || return
	rm -Rf "$appdir"

	# Open the application!
	open "$HOME/Applications"
	echo "Done, opening ~/Applications..."
}

###
 # Gifify's a .mov file and uploads it to CloudUp
 #
 # E.g: gifup myfile.mov (Creates myfile.gif)
 #
 # @since 4/5/16
 ##
function gif-up {
	if [ -e "$1" ]; then
		gifify "$1" && up "$1".gif
	else
		echo "Couldnt find $1"
	fi
}

###
 # Quick wrapper for "npm install && bower install"
 #
 # E.g: install
 #
 # @since 4/5/16
 ##
function install {
	if [ -e 'package.json' ]; then
		echo "Running 'npm install'..."
		npm install
	else
		echo "No package.json, didn't run 'npm install'."
	fi

	if [ '--no-bower' == "$1" ] || [ 'no-bower' == "$1" ]; then
		echo "Didn't run 'bower install' since --no-bower was set."
	else
		if [ -e bower.json ]; then
			echo "Running 'bower install'..."
			bower install
		else
			echo "No bower.json present, didn't run 'bower install'."
		fi
	fi
}

###
 # Pulls files to destination.
 #
 # E.g: rsync-down username@domain:/var/www/ /var/www
 #
 # @since 4/5/16
 ##
function rsync-down {
	rsync -az --progress -e ssh "$1" "$2"
}

###
 # Sends files up to location.
 #
 # E.g: rsync-up /var/www/ username@domain:/var/www/
 #
 # @since 4/5/16
 ##
function rsync-up {
	rsync -avz --progress "$1" -e ssh "$2"
}

###
 # Set tab title.
 #
 # @since Wednesday, January 31, 2018
 ##
function title {
	echo -ne "\033]0;$*\007"
}

###
 # PO 2 MO files conversion.
 #
 # @since Monday, March 19, 2018
 ##
function po2mo {
	if ! [ -x "$(command -v msgfmt)" ]; then
		echo "Please run: brew install gettext" && return
	fi

	if ! [ -x "$(command -v dos2unix)" ]; then
		echo "Please run: brew install dos2unix" && return
	fi

	help="Usage: cd into folder; then run po2mo";
	if [ '--help' == "$1" ]; then
		echo "$help" && return
	fi

	# Clean BOM from .po files: https://unix.stackexchange.com/questions/381230/how-can-i-remove-the-bom-from-a-utf-8-file.
	for f in *.po; do
		dos2unix "$f" &>/dev/null
	done

	# Convert .po to .mo...
	find . -name \*.po -execdir sh -c 'msgfmt "$0" -o `basename $0 .po`.mo' '{}' \;
	echo "Done!"
}

###
 # SVN Add/Remove.
 #
 # @since Friday, March 23, 2018
 ##
function svn-addremove {
	svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
}

###
 # Run gittower.
 #
 # @since Monday, June 4, 2018
 ##
function t {
	gittower ./
}
