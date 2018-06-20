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
 # Wrapper for hcl note "...".
 #
 # @since Wednesday, June 20, 2018
 ##
function note {
	h note "$1"
}
