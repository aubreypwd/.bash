#!/bin/bash

###
 # Harvest Updates
 #
 # @since Wednesday, June 20, 2018
 ##

###
 # Start downtime timer.
 #
 # @since Wednesday, June 20, 2018
 ##
function downtime {
	available
	hcl @downtime "$1".
	here # I must be available.
}

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
	hcl @"$1" "$2"
}

###
 # Wrapper for hcl note "...".
 #
 # @since Wednesday, June 20, 2018
 ##
function note {
	h note "$1"
}
