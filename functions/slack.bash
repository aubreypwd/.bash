#!/bin/bash

###
 # Set custom status message for slack.
 #
 # E.g.
 #     status away "Away." brb (sets to away, sets text status, and :brb: emoji).
 #     status here "Doing something." ducttape @internal.chat
 #
 # @since Tuesday, June 26, 2018
 ##
function status {
	if [ "$1" = 'away' ]; then
		slack presence away > /dev/null 2>&1
	else
		slack presence active > /dev/null 2>&1
	fi

	if [ -n "$2" ]; then
		if [ -n "$3" ]; then
			slack status edit --text "$2" --emoji :"$3": > /dev/null 2>&1
		else
			slack status edit --text "$2" --emoji :ducttape: > /dev/null 2>&1
		fi

		if [ -n "$4" ]; then

			# Run track "$1" @
			hcl "$2" "$4"
		fi
	fi
}
