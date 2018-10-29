#!/bin/bash

###
 # Harvest Updates
 #
 # @since Wednesday, June 20, 2018
 ##

###
 # Stop timer.
 #
 # @since Wednesday, June 20, 2018
 ##
function stop {
	hcl stop
}

###
 # Wrapper for hcl note "...".
 #
 # @since Wednesday, June 20, 2018
 ##
function note {
	hcl note "$1"
}

###
 # Wrapper for hcl (make it act like the rest here).
 #
 # E.g.
 #     h "Note." @internal.chat (start a timer for @internal.chat with this note.)
 #
 # @since Tuesday, June 26, 2018
 ##
function h {
	if [ '--help' == "$1" ]; then
		echo "Usage: h \"[note]\" @alias";
		return
	fi

	hcl "$2" "$1"
}
