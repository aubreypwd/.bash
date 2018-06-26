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
