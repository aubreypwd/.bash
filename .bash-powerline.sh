#!/usr/bin/env bash

__powerline() {

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ $? -eq 0 ]; then
            local BG_EXIT=""
        else
            local BG_EXIT=""
        fi

        PWD="${PWD##*/}"

        # Try and truncate the folder name.
        # pwd_truncated=$(sed 's/^\(.\{25\}\).*/\1/g' <<< "$PWD")
        # if [ "$PWD" != "$pwd_truncated" ]; then
            # PWD="$pwd_truncated..."
        # fi

        PWD="\$ $(pwd)\n"
        PS1="\n"
        PS1+="$FG_BASE03$PWD$RESET"
        PS1+="$(__git_info)"
        PS1+="$FG_BASE03>$RESET "
    }

    PROMPT_COMMAND=ps1
}

# __powerline
# unset __powerline
