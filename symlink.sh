#!/bin/sh
# create relative symlink to the dir in [$XDG_CONFIG_HOME]
ABSP=$(realpath "$0") # get absolute full path of this script
BD=$(dirname "$ABSP") # get base directory path of the script
case "$HOME" in
    /home/*) ;; # if $HOME contains "/home/" -> regular user
    # fix for: root user $HOME=/root etc.
    # HACK: we assume that $BD is inside users home directory
    *) HOME=$(echo "$BD" | grep -o "/home/\w*") ;;
esac
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
# fix: in case parent dirs does not exist
[ ! -d "$XDG_CONFIG_HOME" ] && mkdir -p "$XDG_CONFIG_HOME"
# create relative symlink to the dir
ln -rs "$BD" "$XDG_CONFIG_HOME/mpv"
