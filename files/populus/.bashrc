if [[ ! $DISPLAY ]] && (( XDG_VTNR == 1 )) ; then
   startx
fi

# IDDQD
set -o vi
alias vim='/usr/bin/nvim'
export EDITOR='/usr/bin/nvim'
export VISUAL='/usr/bin/nvim'
export MANPAGER='/usr/bin/nvim +Man!'
export DIFFPROG="/usr/bin/nvim -d" #< for pacdiff.

# IDKFA
for f in ~/.config/bash_completion.d/* ; do
   # shellcheck disable=SC1090
   source "$f"
done

complete -cf sudo

# Aesthetic nonsense:
export PS1='\[\e[34m\]\W\[\e[0m\] \$ '
export LS_COLORS=':di=1;34:ex=1;37:ln=36:so=1;35'

if [[ ! $PATH == *~/bin* ]] ; then
   # shellcheck disable=2088
   export PATH="~/bin:~/.local/bin:${PATH}"
fi

export ELIXIR_EDITOR="alacritty \
   --config-file ${HOME}/.config/alacritty/alacritty.toml \
   --command nvim -R +__LINE__ __FILE__"

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}"/ssh-agent.socket

# Putting a directory at the top level in a user's home dir is genuinely the
# worst. Who thought this was a good idea.
export GOPATH=~/.local/share/go

# Read by `ls` when formatting long output. I don't recall what other commands
# use it.
export TIME_STYLE=+%Y-%m-%d

# usability, builtins, etc.
#-------------------------------------------------------------------------------
alias ..='cd ..'
alias c='clear'
alias cp='cp -vi'
alias diff='diff    --color=auto'
alias grep='grep    --color=auto'
alias l=' \ls -v    --color=auto --group-directories-first --file-type'
alias ls='\ls -v    --color=auto --group-directories-first'
alias ll='\ls -vlh  --color=auto --group-directories-first'
alias la='\ls -vlhA --color=auto --group-directories-first'
alias mkdir='mkdir -pv'
alias mv='mv -vi'
alias rm='rm -vi'
alias kb='xset r rate 200 40'

# administration.
#-------------------------------------------------------------------------------
alias p='paru'
alias sys='sudo -E systemctl'
alias jou='sudo -E journalctl'
alias remnt='sudo systemctl restart media-{share,backup}.mount'

# apps, etc.
#-------------------------------------------------------------------------------
alias bt='sudo bluetoothctl'
alias doc='asciidoctor'
alias f='fzf'
alias hg='chg'
alias ik='vdirsyncer sync && ikhal; clear'
alias k='khal'
alias ka='khard'
alias m='neomutt'
alias o='xdg-open'
alias pw='pass'
alias py='python'
alias r='ranger'
alias sc='sc-im'
alias scm='chez'
alias sdb='chez --debug-on-exception --script'
alias vd='vdirsyncer sync'
alias xp='xclip -i -selection clipboard'
alias xo='xclip -o -selection clipboard'

export MINIKUBE_IN_STYLE=false # fuck off with emojis in the terminal.
alias mk='minikube'
alias mkctl='minikube kubectl --'

function sp { hunspell <<< "$@" ;}
function def { dict "$@" | vim -R +'set ft=dictd' - ;}

alias n='nnn'
declare -x NNN_OPTS=AeEd
declare -x NNN_TRASH=2           # gio trash
declare -x NNN_COLORS='4444'     # color of each tab ("context")
declare -x NNN_FCOLORS
declare -a _nnn_fcolors=(
   00    #  Block device
   00    #  Char device
   04    #  Directory
   0f    #  Executable
   00    #  Regular
   03    #  Hard link
   03    #  Symbolic link
   06    #  Missing OR file details
   01    #  Orphaned symbolic link
   02    #  FIFO
   02    #  Socket
   06    #  Unknown OR empty
)

ifs="$IFS"
IFS='' ; NNN_FCOLORS="${_nnn_fcolors[*]}"
IFS="$ifs"
