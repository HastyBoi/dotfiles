#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
source "$HOME/.cargo/env"

source /home/hasty/.config/broot/launcher/bash/br

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
#[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- -nocursor vt1
