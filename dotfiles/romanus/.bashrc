if [[ ! $DISPLAY ]] && (( XDG_VTNR == 1 )) ; then
   startx
fi

# IDDQD
set -o vi
alias vim='nvim'
export EDITOR="nvim"

# IDKFA
for f in ~/.config/bash_completion.d/* ; do
   # shellcheck disable=SC1090
   source "$f"
done

complete -cf sudo

# Aesthetic nonsense:
PS1='\[\e[34m\]\W\[\e[0m\] \$ '
export LS_COLORS=':di=1;33:ex=1;37:ln=36'

export PATH="${PATH0:-~/bin:~/.local/bin:$PATH}"
export PATH0="$PATH"

export ELIXIR_EDITOR="alacritty \
   --config-file ${HOME}/.config/alacritty/alacritty.toml \
   --command nvim -R +__LINE__ __FILE__"

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}"/ssh-agent.socket

# Putting a directory at the top level in a user's home dir is genuinely the
# worst. Who thought this was a good idea.
export GOPATH=~/.local/share/go

# usability, builtins, etc.
#-------------------------------------------------------------------------------
alias ..='cd ..'
alias c='clear'
alias l=' \ls      --color=auto --file-type'
alias ls='\ls      --color=auto --group-directories-first'
alias ll='\ls -lh  --color=auto --group-directories-first'
alias la='\ls -lhA --color=auto --group-directories-first'
alias lt='\ls -1ht --color=auto | head'
alias rm='rm -vi'
alias mv='mv -vi'
alias mkdir='mkdir -pv'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ping1='ping -c1 -W1 1.1.1.1 && echo OK'

alias di='dirs -v'
function pu {
   if (( $# )) ; then
      pushd "$@" >/dev/null || return
   else
      pushd      >/dev/null || return
   fi
   dirs -v
}
function po {
   if [[ $1 ]] ; then
      popd "+${1}" >/dev/null || return
   else
      popd         >/dev/null || return
   fi
   dirs -v
}

function kb {
   setxkbmap -option caps:escape
   xinput set-prop "DLL082A:01 06CB:76AF Touchpad" "libinput Tapping Enabled" 1
   xset r rate 200 40
}

complete -W 'laptop desktop' mon
function mon {
   # TODO;
   # May want to just do this with udev rules. I'll never be connecting to
   # external monitors aside from the ones at my own desk. Fairly consistent
   # setup.

   case "$1" in
      laptop)
         xrandr \
            --output e-DP1 --off \
            --output DP1 --auto --primary \
            --output DP2 --auto --right-of DP1
         ;;

      desktop)
         xrandr \
            --output e-DP1 --auto \
            --output DP1 --off    \
            --output DP2 --off
         ;;

      *) printf 'Expecting: ["laptop", "desktop"].\n'
         return 1
   esac
}

# administration.
#-------------------------------------------------------------------------------
alias p='paru'
alias sys='sudo -E systemctl'
alias jou='sudo -E journalctl'
alias remnt='sudo systemctl restart media-{share,backup}.mount'

# apps, etc.
#-------------------------------------------------------------------------------
alias o='xdg-open'
alias r='ranger'
alias m='neomutt'
alias py='python'
alias bt='sudo bluetoothctl'
alias xp='xclip -i -sel c'
alias pw='pass'
alias doc='asciidoctor'
alias vd='vdirsyncer sync'
alias ik='vdirsyncer sync && ikhal; clear'
alias k='khal'
alias ka='khard'
alias sc='sc-im'
alias f='fzf'
alias hg='chg'
alias scm='chez'
alias sdb='chez --debug-on-exception --script'

export MINIKUBE_IN_STYLE=false # fuck off with emojis in the terminal.
alias mk='minikube'
alias mkctl='minikube kubectl --'

function steno {
   local dir today
   dir="${HOME}/Documents/steno"
   today=$(date +%Y-%m-%d)
   nvim -c 'set filetype=steno' '+norm GI' "${dir}/${today}"
}
