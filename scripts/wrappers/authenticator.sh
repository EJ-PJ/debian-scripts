#!/bin/sh

name=Authenticator
totp_prog=cotp-wrap

term_geom="118x32"

run_without_terminal=""

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

# terminal window geometry
term_geom="$term_geom"

# werether to run the desired totp without a terminal
# setting to a value different from empty will just run
# the totp program as is, otherwise x-terminal-emulator is used
run_without_terminal="$run_without_terminal"
__HEREDOC__
fi


if [ -z "$run_without_terminal" ]; then
    exec x-terminal-emulator -g "$term_geom" -T "$name" -e "$totp_prog"
else
    exec "$totp_prog"
fi
