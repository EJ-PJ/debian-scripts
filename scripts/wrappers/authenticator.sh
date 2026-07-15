#!/bin/sh

name=Authenticator
totp_prog=cotp

config_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/totp-authenticator"
config_file="${config_dir}/configrc"

if [ -r "$config_file" ]; then
    . "$config_file"
else
    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
    fi
    cat << __HEREDOC__ > "$config_file"
# vim: ft=sh
# authenticator config file

# name
name="${name}"

# program to launch
totp_prog="$totp_prog"
__HEREDOC__
fi


x-terminal-emulator -g 118x32 -T "$name" -e "$totp_prog"
