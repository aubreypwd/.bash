#!/bin/bash

###
 # LBF (Local by Flywheel) functions.
 #
 # @since Friday, January 4, 2019
 ##

function lbf {
	if [ '--help' == "$1" ]; then
		echo "Usage: lbf [smb,] <E.g. smb will connect you to SMB.>"
		return
	fi

	if [ 'smb' == "$1" ]; then /Users/aubreypwd/Library/Application\ Support/Local\ by\ Flywheel/ssh-entry/SJDt9G2A7.sh; fi
	if [ 'ms-365' == "$1" ]; then /Users/aubreypwd/Library/Application\ Support/Local\ by\ Flywheel/ssh-entry/H1uE90qC7.sh; fi
	if [ 'discover-office' == "$1" ]; then /Users/aubreypwd/Library/Application\ Support/Local\ by\ Flywheel/ssh-entry/SkYUh_bx4.sh; fi
	if [ 'discover-ms' == "$1" ]; then /Users/aubreypwd/Library/Application\ Support/Local\ by\ Flywheel/ssh-entry/BJLchuWx4.sh; fi
}
