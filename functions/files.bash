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

	where="."
	if [ -n "$1" ]; then
		where=${1%/}
	fi

	if [ '-R' == "$1" ]; then
		dirs "." && return
	fi

	dirs "$where" 1
}

###
 # Goto a Valet site.
 #
 # E.g: valet
 #
 # @since Tuesday, April 23, 2019
 ##
function v {
	cd "$HOME/Valet" || return
	site "./"
}

###
 # Goto a site.
 #
 # @since Monday, March 19, 2018
 ##
function site {
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
