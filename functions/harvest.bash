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
 # Wrapper for hcl.
 #
 # @since Wednesday, June 20, 2018
 ##
function h {
	hcl "$1" "$2" "$3" "$4" "$5"
}

###
 # Easy way to update harvest on what I'm doing.
 #
 # Uses an alias, e.g. doing maintainn.chat "Chatting..."
 # will run hcl @maintainn.chat "Chatting".
 #
 # @since Wednesday, June 20, 2018
 ##
function doing {
	hcl @"$2" "$1"
}

###
 # Wrapper for hcl note "...".
 #
 # @since Wednesday, June 20, 2018
 ##
function note {
	h note "$1"
}
