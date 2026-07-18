# wrappers

Tiny wrappers for some commands


## servicectl

A wrapper around update-rc.d(8) and service(8) to feel similar to systemctl and dispatch actions to
multiple services, useful if you just came from regular debian or another GNU+systemd distro and got
too much muscle memory of systemctl

## gldl

A wrapper for gallery-dl to automatically get the cookies from the default web browser and running
keyring, useful if you do not run a full fledged desktop environment, able to use the binary
installed by either apt or pip/pipx.


## ytdl

A wrapper for yt-dlp to automatically get the cookies from the default web browser and running
keyring, useful if you do not run a full fledged desktop environment, able to use the binary
installed by either apt or pip/pipx.

## rofi-askpass

A wrapper for using rofi as a SUDO_ASKPASS provider, just copy to somewhere in your path, ideally in
`/usr/local/bin` and set the SUDO_ASKPASS var, if you want to keep in with debian convention and
have something in the expected location then link the script to `/usr/bin/ssh-askpass` and just set
`SUDO_ASKPASS=/usr/bin/ssh-askpass` in your profile.
Configuration is a regular rofi config.rasi file located at:
`${XDG_CONFIG_HOME:-$HOME/.config}/rofi-askpass/config.rasi`

## authenticator.sh

A shallow wrapper for a totp authentication program, a .desktop file `authenticator.desktop` is
provided, the desktop file launchs specifically this script, the script itself is very agnostic to
the actual totp program as it can work with either a GUI or TUI program, even custom scripts, altho
it is geared towards working with the provided cotp-wrap script.
Configuration is a key val file located at:
`${XDG_CONFIG_HOME:-${HOME}/.config}/totp-authenticator/configrc`
