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
	slack status edit --text "Working/Delayed Response. $1" --emoji :matrix: > /dev/null 2>&1
}

###
 # I'm here.
 #
 # @since Tuesday, June 19, 2018
 ##
function here {
	# /status :ducttape: Available.
	slack status edit --text "Available. $1" --emoji :ducttape: > /dev/null 2>&1
}

###
 # I'm afk.
 #
 # @since Tuesday, June 19, 2018
 ##
function afk {
	# /status :brb: Lunch/Coffee BRB.
	slack status edit --text "Lunch/Coffee BRB. $1" --emoji :brb: > /dev/null 2>&1
}
