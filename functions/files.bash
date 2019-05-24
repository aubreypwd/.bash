#!/bin/bash

###
 # Directory and files functions.
 #
 # @since 3/11/17 Move to it's own file from functions.bash.
 ##

# shellcheck disable=SC2120
# shellcheck disable=SC2119

###
 # Fuzzy find directories (recursive).
 #
 # @since Monday, March 19, 2018
 ##
function dirs {
	help="dir [+string Folder you want to look at, defaults to current.] [+number The max depth, e.g. 1; left blank, defaults to unlimited.]";
	if [ '--help' == "$1" ]; then
		echo "$help" && return
	fi

	depth=""
	if [ -n "$2" ]; then
		depth="-maxdepth $2"
	else
		depth=""
	fi

	thedir=$(find "${1:-./}" -path '*/\.*' -prune \
		-o -type d $depth -print 2> /dev/null | fzf +m) && cd "$thedir" || return
}

###
 # Fuzzy find a directory (non-recursive).
 #
 # @since Monday, March 19, 2018
 ##
function dir {
	help="dir [+string Folder you want to look at, or pass -R to search recursively (will forgo depth).]"
	if [ '--help' == "$1" ]; then
		echo "$help" && return
	fi

	where="./"
	if [ -n "$1" ]; then
		where=${1%/}
	fi

	if [ '-R' == "$1" ]; then
		dirs "." && return
	fi

	dirs "$where" 1
}

###
 # Jump to a Theme
 #
 # E.g: theme
 #
 # @since Friday, May 24, 2019
 ##
function theme {
	if [ -e "wp-content" ]; then
		wp-content
	fi

	if [ -e "themes" ]; then
		cd "themes" || return
		dir ./
	fi
}

###
 # Better cd with Ranger support.
 #
 # E.g: cd
 #
 # @since Friday, May 24, 2019
 ##
function cd {
	if [ -n "$1" ]; then
		builtin cd "$@" || return
		return
	fi

	ranger ./ --show-only-dirs --choosedir="$HOME/.rangerdir"
	LASTDIR=$(cat "$HOME/.rangerdir")
	cd "$LASTDIR" || return
}

###
 # Jump to a Plugin.
 #
 # E.g: plugin
 #
 # @since Friday, May 24, 2019
 ##
function plugin {
	if [ -e "wp-content" ]; then
		wp-content
	fi

	if [ -e "plugins" ]; then
		cd "plugins" || return
		dir ./
	fi
}

###
 # Get to the wp-contet dir.
 #
 # E.g: wp-content
 #
 # @since Friday, May 24, 2019
 ##
function wp-content {
	if [ -e "wp-content" ]; then
		cd "wp-content" || return
	else
		site
		wp-content
	fi
}

###
 # Goto a Valet site.
 #
 # E.g: valet
 #
 # @since Tuesday, April 23, 2019
 ##
function site {
	cd "$HOME/Valet" || return
	_site "./"
}

###
 # Goto a site.
 #
 # @since Monday, March 19, 2018
 ##
function _site {
	dir "$1"

	# Try and go to wp-content...
	if [ -e "wp-content" ]; then
		cd "wp-content" || return

		# Try and go to any other path they supply.
		if [ -e "$1" ]; then
			cd "$1" || return
		fi

		return
	fi

	# Try and go to public folder.
	if [ -e "app/public" ]; then
		cd "app/public" || return

		# Try and go to any other path they supply.
		if [ -e "$1" ]; then
			cd "$1" || return
		fi

		return;
	fi
}

###
 # Goto the public/ dir of a site.
 #
 # @since Monday, March 19, 2018
 ##
function public {
	site && cd "app/public/" || return
}

###
 # Get to the wp-content of a site.
 #
 # @since Monday, March 19, 2018
 ##
function wp-content {
	public && cd "wp-content" || return
}

###
 # Delete permanently.
 #
 # @since Wednesday, August 15, 2018
 ##
function delete {
	rm -Rf "$1"
}

###
 # Add comment to a file.
 #
 # E.g: comment "file.png" "comment"
 #
 # @since Tuesday, May 21, 2019
 ##
function comment {
	osascript -e 'on run {f, c}' -e 'tell app "Finder" to set comment of (POSIX file f as alias) to c' -e end "$1" "$2" > /dev/null 2>&1
}

###
 # Wrapper or aria2c
 #
 # E.g: download 12 "http://..."
 #
 # @since Tuesday, May 21, 2019
 ##
function download {
	aria2c -x "$1" "$2"
}
