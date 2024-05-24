#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#Display ISO version and distribution information in short
alias version="sed -n 1p /etc/os-release && sed -n 12p /etc/os-release && sed -n 13p /etc/os-release"