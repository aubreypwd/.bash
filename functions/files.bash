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
function dir-recursive {
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

	where="."

	if [ -n "$1" ]; then
		where=${1%/}
	fi

	if [ '-R' == "$2" ]; then
		dirs "." && return
	fi

	dirs "$where" 1
}

###
 # Easy way to find a directory in current directory.
 #
 # E.g: dirf or dirf .
 ##
function dirf {
	where="."

	if [ -n "$1" ]; then
		where="$1"
	fi

	echo "$where"

	dir "$where" -R
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
	if [ -e "plugins" ]; then
		cd "plugins" || return
		dir ./
	else
		wp-content
		plugin
	fi
}

###
 # Jump to a Theme
 #
 # E.g: theme
 #
 # @since Friday, May 24, 2019
 ##
function theme {
	if [ -e "themes" ]; then
		cd "themes" || return
		dir ./
	else
		wp-content
		theme
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
		site --wp-content
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
	dir ./

	if [ '--wp-content' == "$1" ]; then
		wp-content
	fi
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
