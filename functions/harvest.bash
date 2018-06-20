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
	hcl @downtime Misc downtime.
}

###
 # Stop timer.
 #
 # @since Wednesday, June 20, 2018
 ##
function stop {
	hcl stop
}
