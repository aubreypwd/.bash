__git_info() {
    [ -x "$(which git)" ] || return    # git not found

    local git_eng="env LANG=C git"   # force git output in English to make our work easier
    # get current branch name or short SHA1 hash for detached head
    local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
    [ -n "$branch" ] || return  # git branch not found

    # Try and truncate the branch.
    # branch_truncated=$(sed 's/^\(.\{25\}\).*/\1/g' <<< "$branch")
    # if [ "$branch" != "$branch_truncated" ]; then
        # branch="$branch_truncated..."
    # fi

    local marks

    # branch is modified?
    [ -n "$($git_eng status --porcelain)" ] && marks+=" $FG_MAGENTA$GIT_BRANCH_CHANGED_SYMBOL$RESET"

    # how many commits local branch is ahead/behind of remote?
    local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
    local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
    local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
    [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
    [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

    # GIT_SEP="·"
    GIT_SEP=""

    GIT_REMOTE=$($git_eng config --get remote.origin.url)

    if ! [ -e $GIT_REMOTE ]; then
    	GIT_REMOTE="$FG_BLUE$GIT_REMOTE"
    else
    	GIT_REMOTE=""
    fi

    # print the git branch segment without a trailing newline
    echo "$FG_BASE03$GIT_SEP$GIT_REMOTE$FG_ORANGE $GIT_BRANCH_SYMBOL$RESET$FG_GREEN$branch$marks"
}
