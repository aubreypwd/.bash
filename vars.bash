#!/bin/bash

# Unicode symbols
PS_SYMBOL_DARWIN=''
PS_SYMBOL_LINUX='$'
PS_SYMBOL_OTHER='%'
GIT_BRANCH_SYMBOL='⑂ '
GIT_BRANCH_CHANGED_SYMBOL='++'
GIT_NEED_PUSH_SYMBOL='⇡'
GIT_NEED_PULL_SYMBOL='⇣'

# Solarized colorscheme
FG_BASE03="$(tput setaf 8)"
FG_BASE02="$(tput setaf 0)"
FG_BASE01="$(tput setaf 10)"
FG_BASE00="$(tput setaf 11)"
FG_BASE0="$(tput setaf 12)"
FG_BASE1="$(tput setaf 14)"
FG_BASE2="$(tput setaf 7)"
FG_BASE3="$(tput setaf 15)"

BG_BASE03="$(tput setab 8)"
BG_BASE02="$(tput setab 0)"
BG_BASE01="$(tput setab 10)"
BG_BASE00="$(tput setab 11)"
BG_BASE0="$(tput setab 12)"
BG_BASE1="$(tput setab 14)"
BG_BASE2="$(tput setab 7)"
BG_BASE3="$(tput setab 15)"

FG_YELLOW="$(tput setaf 3)"
FG_ORANGE="$(tput setaf 9)"
FG_RED="$(tput setaf 1)"
FG_MAGENTA="$(tput setaf 5)"
FG_VIOLET="$(tput setaf 13)"
FG_BLUE="$(tput setaf 4)"
FG_CYAN="$(tput setaf 6)"
FG_GREEN="$(tput setaf 2)"

BG_YELLOW="$(tput setab 3)"
BG_ORANGE="$(tput setab 9)"
BG_RED="$(tput setab 1)"
BG_MAGENTA="$(tput setab 5)"
BG_VIOLET="$(tput setab 13)"
BG_BLUE="$(tput setab 4)"
BG_CYAN="$(tput setab 6)"
BG_GREEN="$(tput setab 2)"

DIM="$(tput dim)"
REVERSE="$(tput rev)"
RESET="$(tput sgr0)"
BOLD="$(tput bold)"
