#!/bin/bash

###
 # Slack Status'
 #
 # @since Tuesday, June 19, 2018
 ##

###
 # I'm working.
 #
 # E.g.
 #     working (Just set my status)
 #     working "Doing something important." (Add a note to my status)
 #     working "Doing something important." internal.chat (Also start a timer for this alias with the note)
 #
 # @since Tuesday, June 19, 2018
 ##
function working {
	# /status :matrix: Working/Delayed Response.
	slack presence active > /dev/null 2>&1
	slack status edit --text "Working/Delayed Response. ($1)" --emoji :matrix: > /dev/null 2>&1

	if [ -n "$2" ]; then

		# Run doing "$1" @
		doing "$2" "$1"
	fi
}

###
 # Wrapper for here().
 #
 # @since Wednesday, June 20, 2018
 ##
function available {
	here "$1"
}

###
 # I'm here.
 #
 # E.g.
 #     here (just set my status)
 #     here "Just sitting around doing nothing." (add note to my status)
 #     here "Figuring out what to do" internal.chat (Also start a tracker with my note)
 #
 # @since Tuesday, June 19, 2018
 ##
function here {
	# /status :ducttape: Available.
	slack presence active > /dev/null 2>&1
	slack status edit --text "Available. ($1)" --emoji :ducttape: > /dev/null 2>&1

	if [ -n "$2" ]; then

		# Run doing "$1" @
		doing "$2" "$1"
	fi
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
	slack status edit --text "AFK; Lunch/Coffee/Break BRB. ($1)" --emoji :brb: > /dev/null 2>&1
}

###
 # I'm on a call!
 #
 # E.g.
 #     call (just set my status)
 #     call "On a call with Ben" (add a note to my status)
 #     call "On a call with Ashley" devblogs.chat (Also start a timer for this alias with a note)
 #
 # @since Wednesday, June 20, 2018
 ##
function call {
	slack presence away > /dev/null 2>&1
	slack status edit --text "Internal/Client Call. ($1)" --emoji :phone: > /dev/null 2>&1

	if [ -n "$2" ]; then

		# Run doing "$1" @
		doing "$2" "$1"
	fi
}

###
 # Off for the night.
 #
 # @since Wednesday, June 20, 2018
 ##
function off {
	slack presence away > /dev/null 2>&1
	slack status edit --text "Off for the day. ($1)" --emoji :night_with_stars: > /dev/null 2>&1
	stop # Stop all timers
}
