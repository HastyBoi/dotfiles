# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# add colors to tty
if [ "$TERM" = "linux" ]; then
    #echo -en "\e]P01B1D23" #black
    echo -en "\e]P0111111" #black
    echo -en "\e]P8282C34" #darkgrey
    echo -en "\e]P1E06C75" #darkred
    echo -en "\e]P9E06C75" #red
    echo -en "\e]P298C379" #darkgreen
    echo -en "\e]PA98C379" #green
    echo -en "\e]P3E5C07B" #brown
    echo -en "\e]PBE5C07B" #yellow
    echo -en "\e]P461AFEF" #darkblue
    echo -en "\e]PC61AFEF" #blue
    echo -en "\e]P5C678DD" #darkmagenta
    echo -en "\e]PDC678DD" #magenta
    echo -en "\e]P656B6C2" #darkcyan
    echo -en "\e]PE56B6C2" #cyan
    echo -en "\e]P7ABB2BF" #lightgrey
    echo -en "\e]PFABB2BF" #white
    clear
fi

# prikaldes
figlet $USER | lolcat --seed=100

# enable vim mode
set -o vi

# change prompt
PS1='\[\033[01;34m\]\W\[\033[00m\]\$ '

# enable/disable nvm to improve bash load time
NVM_ENABLE=false
if [ "$NVM_ENABLE" = true ]
then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
    alias nvm='cowsay tak epta, ustanovi NVM_ENABLE=true v ~/.bashrc | lolcat'
fi

source "$HOME/.cargo/env"

#source ~/.bash_completion.d/alacritty

# disable scroll lock on ctrl+s
stty -ixon

## this should be in ~/.xprofile or ~/.xsession
#xset r rate 215 42

# add colors to man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

source /home/hasty/.config/broot/launcher/bash/br
