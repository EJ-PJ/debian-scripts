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

## cotp-wrap

A wrapper for cotp. The cotp program is great for a TUI totp authenticator, but it has some annoying
well not features but rather quirks of configuration and usability which may make it annoying to use
the more irking which this wrapper addresses is the need to type in a password every time you open
the program to get a One Time Password, fortunately cotp has the option to take a password from
stdin, which means we can leverage the secret storage keyring (like gnome keyring) and secret-tool,
you need secret-tool and a running secrets storage service running (kwallet, gnome-keyring).
Configuration located at:
"${XDG_CONFIG_HOME:-${HOME}/.config}/cotp-wrap/configrc"

To setup your password first run:
```sh
secret-tool store --label="authenticator password" application authenticator
```
enter your desired password, run cotp for the first time and enter your chosen password again, even
if you run cotp-wrap it will require the password.

To actually add an OTP code there are many ways but the one that has worked for me has been to use
OTP QR codes, say like the ones you get from github, gitlab, microsoft, etc... altho cotp can render
the QR code in the TUI it has no native way to import a QR code, what i use is the program zbarimg
from the zbar-tools package to extract the otp uri, then leverage a text type tool (xdotool type in
x11) to enter the uri in the entry dialog provided by running:
```sh
cotp add --otpuri --label "<my otp label>"
```
replace the text in between `<>` with your desired label, for example gitlab for your gitlab OTP
