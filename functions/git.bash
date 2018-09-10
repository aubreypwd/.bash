#!/bin/bash

###
 # Git Functions.
 #
 # @since 3/11/17 Move to it's own file from functions.bash.
 ##

###
 # Checkout a branch fuzzily.
 #
 # @since 5/15/17
 ##
function branch {
	local branches branch
	branches=$(git branch -a) &&
	branch=$(echo "$branches" | fzf +s +m -e) &&
	cmd=$(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
	git checkout "$cmd"
}

###
 # Alias for git fetch --all.
 #
 # @since 7/6/17
 ##
function fetch {
	git fetch --all
}

###
 # What is this branch's parent branch.
 #
 # @since 3/16/17
 ##
function git-parent-branch {
	git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
}

###
 # Remove an item from history.
 #
 # This is dangerous, it changes history and breaks things!
 #
 # @since 2/7/17
 ##
function git-remove-from-history {

	# Make sure the user wants to do this before actually fucking with the git repo.
	read -p "Are you sure you want to remove this from history, this can't be undone!? (Y/n)? " -r confirm

	if [ 'Y' != "$confirm" ]; then
		return;
	fi;

	# Remove from history, see http://stackoverflow.com/a/17824718
	git filter-branch --tree-filter "rm -rf $1" --prune-empty HEAD
	git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
	git commit -m "Removing $1 from git history..."
	git gc

	# Show the user the status.
	git status

	# Give the user an opportunity to cancel.
	read -p "We're ready to push to master and change history, are you sure (Y/n)? " -r confirm

	if [ 'Y' == "$confirm" ]; then

		# Break things!
		git push origin master --force
	fi
}

###
 # Add files, except chores.
 #
 # Adds all files, removes chore files, then shows you a status.
 #
 # @since 2/1/17
 ##
function git-no-chores {
	git add .
	rm-chores
	git status
}

###
 # Wrapper for copy-branch.
 #
 # @since 4/5/16
 ##
function cb {
	git branch | grep '\*' | tr -d '* \n' | pbcopy
}

###
 # Wrapper for git-delete-branch().
 #
 # @since 11/22/16
 ##
function git-delete-branch {
	git branch -D "$1" && git push origin :"$1"
}

###
 # Puts a branch into another branch.
 #
 # @since 4/5/16
 ##
function git-put-patch {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-put-patch [+string: Branch to be merged. <my-branch>] [+string: Branch to be merged into. <master>]"
			return;
	fi

	if [ -n "$1" ] && [ -n "$2" ]; then
		git-patch "$2"       # Create a patch and upload to cloudup.
		git checkout "$2"    # Checkout the target branch.
		git merge --commit --no-ff "$1"       # Merge in the intended branch.

		# Let them know what happened.
		echo "Patched $1 against $2, checked out $2 and merged in $1."

		# Bail here, success!
		return;
	fi

	git-put-patch --help
}

	###
	 # Put this branch into another.
	 #
	 # @since 4/6/16
	 ##
	function git-put {
		if [ '--help' == "$1" ]; then
			echo "Usage: git-put [+string: Branch to be merged. <my-branch>] [+string: Branch to be merged into. <master>]"
				return;
		fi

		if [ -n "$1" ]; then

			# Get the current branch.
			branch="$(git branch|grep '\*'|tr -d '* \n')"

			# Checkout and merge.
			git checkout "$1"      # Checkout the target branch.
			git merge --commit --no-ff "$branch"    # Merge in the intended branch.

			# Let them know what happened.
			echo "Checked out $1 and merged in $branch."

			# Bail here, success!
			return;
		fi

		git-put --help
	}

###
 # Simple log.
 #
 # @since 5/4/16 Re-written to use simple log.
 ##
function git-log {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-log [string: Mode <graph>]"
		return;
	fi

	if [ 'graph' == "$1" ]; then
		git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
	else
		if [ "$1" -gt 0 ]; then
			git log -n "$1" --oneline
		else
			let lines=$LINES-10 # Just under the current lines of the window.
			git log -n "$lines" --oneline
		fi
	fi
}

###
 # Pushes the current branch.
 #
 # E.g.: git-push
 #
 # @since 4/5/16
 ##
function git-push {
	git push origin "$(git branch|grep '\*'|tr -d '* \n')"
}

	###
	 # Wrapper for git-push
	 #
	 # @since 4/5/16
	 ##
	function push {
		git-push
	}

	###
	 # Super quick way to push (Deprecated).
	 #
	 # @since 5/5/16
	 # @since 11/28/16 Deprecated because p could mean either push or pull and it gets confusing, use push() and pull() instead.
	 # @since 11/29/16 Push it! Push it!
	 ##
	function p {
		push
	}

###
 # Creates a patch using Git.
 #
 # E.g: git-patch-up file.diff (Creates a patch as file.diff)
 #
 # @since 4/5/16
 # @since 11/22/16 Updated this to be git-patch-up
 ##
function git-patch-up {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-patch-up [+string: Branch name to patch current branch against. <master, prod>] [+string: File Name. <my-diff.patch, my-diff.diff>]"
		return;
	fi

	if [ -n "$1" ] && [ -n "$2" ]; then
		git diff "$1"... --no-prefix > "$2"
		up "$2"
		return;
	fi

	# Show help for this command.
	git-patch-up --help
}

###
 # Quick patch
 #
 # E.g.: git-patch branch
 #
 # @since 4/5/16
 ##
function git-patch {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-patch [+string: Branch Name to build patch against. <master>]";
		return;
	fi

	if [ -n "$1" ]; then
		current_time=$(date "+%Y-%m-%d-%H-%M-%S")
		git-patch-up "$1" "$HOME/Downloads/$current_time.diff"

		# Bail, we patched.
		return;
	fi

	echo "Can't path $1."
}

###
 # Pulls down the current branch.
 #
 # E.g.: git-pull | pull
 #
 # @since 4/5/16
 ##
function git-pull {
	git pull origin "$(git branch|grep '\*'|tr -d '* \n')"
}

	###
	 # Wrapper for git-pull
	 #
	 # @since 4/5/16
	 ##
	function pull {
		git-pull
	}

###
 # Quick wrapper for "git submodule init && git submodule update"
 #
 # E.g: submodules
 #
 # @since 4/5/16
 ##
function submodules {
	git submodule update --init --recursive
}

	###
	 # Wrapper for submodules.
	 #
	 # @since 11/22/16 submodules is hard to type.
	 ##
	function modules {
		submodules
	}

	###
	 # Wrapper for submodules.
	 #
	 # @since 3/11/17 submodules is hard to type.
	 ##
	function git-modules {
		submodules
	}

###
 # Get the count of commits for the day.
 #
 # E.g. count-commits
 #
 # @since 8/12/2016
 ##
function git-commits {
	git shortlog -s -n
}

###
 # Get my commit count for the day.
 #
 # E.g. count-commits-today
 #
 # @since 8/12/16
 ##
function git-commits-today {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-commits-today [int: Since Time. {6am}, <5pm>] [string: Full Name. {Aubrey Portwood}, <James Brown>]";
		return;
	fi

	# My name by default.
	name="Aubrey Portwood"

	# Default since 6am.
	since="6am"

	if [ -n "$1" ]; then

		# The user wants a value.
		since=$1
	fi

	if [ -n "$2" ]; then

		# User input name.
		name=$2
	fi

	# Log the commits today since $since for the $name.
	git shortlog -s -n --since="$since" | grep "$name"
}

###
 # Count commits since many days ago.
 #
 # Will show commit count
 #
 # E.g. count-commits-since 5
 ##
function git-commits-since {
	if [ '--help' == "$1" ]; then
		echo "Usage: git-commits-today [int: Last # Days. {7}, <8>] [string: Full Name. {Aubrey Portwood}, <James Brown>]"
		return;
	fi

	# Default to 7 days.
	days=7

	# Default name is me :D
	name="Aubrey Portwood"

	if [ -n "$1" ] && [ "$1" -gt 0 ]; then

		# User input of how many days.
		days=$1
	fi

	if [ -n "$2" ]; then
		name=$2
	fi

	# Log commits since
	git shortlog -s -n --since="$days days ago" | grep "$name"
}

###
 # Delete a tag.
 #
 # @since 12/6/2017
 ##
function git-delete-tag {
	git tag -d "$1"
	git push origin :refs/tags/"$1"
}

###
 # Make a git repo not a git repo for Ben.
 #
 # @since 12/5/17
 ##
function ungit {

	if [ ! -e ".git" ]; then
		echo "This doesn't appear to be a Git repo, no .git* folders or files, maybe you meant to run regit?"
		return;
	fi

	# What is the current directory's path md5 name?
	directory=$( PWD | md5 )

	# The place where we'll temporarily store .git stuff.
	location="/tmp/$directory"

	# The location already exists.
	if [ -e "$location" ]; then
		echo "$location already exists, not sure why, but let's just use it, why not?"
	else

		# Make the temporary location.
		mkdir "$location"
	fi

	# Move the .git files to this location.
	mv .git* "$location/"
	echo "Moved .git files to $location temporarily, run ungit when you're ready to turn this back into a repo."
}

###
 # Make a previously ungit repo a git repo again..for Ben.
 #
 # @since 12/5/17
 ##
function regit {

	# What is the current directory's path md5 name?
	directory=$( PWD | md5 )

	# The place where we'll temporarily store .git stuff.
	location="/tmp/$directory"

	# If the location exists (we did ungit before).
	if [ -e "$location" ]; then

		# Move the .git files back.
		mv "$location/"/.git* ./

		# Remove the location folder, we're back where we want to be.
		trash -Rf "$location"

		echo ".git folders moved back, we trashed $location."
	else
		echo "$location does not exist, you must not have ungit."
	fi
}

###
 # Show tags and their commits.
 # E.g: git-tags
 #
 # @since Sep 10, 2018
 ##
function git-tags {
	git show-ref --tags
}
