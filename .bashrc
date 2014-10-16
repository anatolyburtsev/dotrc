# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && exit 0

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
__res () {
        case $1 in
                0) : ;;
                *) printf '%d ' $1 ;;
        esac
}
PS1='$(__res $?)'${PS1}

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

gr(){ egrep -v '^#|^$' $1; }
genpass(){ strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo; }
repapprove(){ sudo gpg --keyserver subkeys.pgp.net --recv $1; sudo gpg --export --armor $1 | sudo apt-key add -; }
pckg2st(){ if [ "$#" -eq "0" ] ; then echo "launch \"pckg2st pattern\""; return 0; fi; ptrn=$1 ; dpkg -l |grep $ptrn|awk '{ print $2 " " $3}' | while read -r line; do echo sudo dmove -sep stable $line unstable; done; }
genhost() { hn=$1; host $hn|head -1|awk '{print $NF}'|tr '\n' ' '; host $hn|head -1|awk '{print $1}'|tr '\n' ' '; echo $hn|sed -e 's/\..*//g'; }

LANG="en_US.UTF-8"

export MYSQL_PS1="\u@\h [\d]> "
export DEBFULLNAME='Anatoly BUrtsev'
export DEBEMAIL='onotole@yandex-team.ru'
export EDITOR='vim'
export PAGER=less
export LESS='-iFXc'
export EDITOR=vim
export VISUAL=$EDITOR
export SVN_SSH="ssh -q -l onotole"
export DEBIAN_FRONTEND=noninteractive

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias g='grep -Rnif - . 2>/dev/null |grep -v "Binary file" <<<'
alias s='ssh'
alias la='ls -la'
alias ll='ls -l'
alias ltr='ls -ltr'
alias ldir='ls -aldFG'
alias pss="ps auwwx| grep -v grep | grep  "
alias free="free -m"
alias dupload='dupload --nomail'
alias dch='dch --distributor=debian --no-auto-nmu'
alias debuild='debuild --no-tgz-check'
alias suod=sudo
alias sduo=sudo
alias sdou=sudo
alias sodu=sudo
alias soud=sudo
alias grpe=grep
alias h='history'
alias hh='history | egrep -i'
alias tmux='tmux attach || tmux new'
#Directory SiZe
alias dsz='du -s `pwd`/* | sort -nr | cut -f 2- | while read a; do du -sh "$a"; done|head'
alias dszr='sudo du -s `pwd`/* 2>/dev/null| sort -nr | cut -f 2- | while read a; do sudo du -sh "$a" 2>/dev/null; done|head'
