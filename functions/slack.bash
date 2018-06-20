#!/bin/bash

###
 # Slack Status'
 #
 # @since Tuesday, June 19, 2018
 ##

###
 # I'm working.
 #
 # @since Tuesday, June 19, 2018
 ##
function working {
	# /status :matrix: Working/Delayed Response.
	slack presence active > /dev/null 2>&1
	slack status edit --text "Working/Delayed Response. $1" --emoji :matrix: > /dev/null 2>&1
}

###
 # I'm here.
 #
 # @since Tuesday, June 19, 2018
 ##
function here {
	# /status :ducttape: Available.
	slack presence active > /dev/null 2>&1
	slack status edit --text "Available. $1" --emoji :ducttape: > /dev/null 2>&1
}

###
 # I'm afk.
 #
 # @since Tuesday, June 19, 2018
 ##
function afk {
	# /status :brb: Lunch/Coffee BRB.
	hcl stop # Stop Harvest.
	slack presence away > /dev/null 2>&1
	slack status edit --text "Lunch/Coffee BRB. $1" --emoji :brb: > /dev/null 2>&1
}

###
 # I'm on a call!
 #
 # @since Wednesday, June 20, 2018
 ##
function call {
	slack presence away > /dev/null 2>&1
	slack status edit --text "Internal/Client Call. $1" --emoji :phone: > /dev/null 2>&1
}
