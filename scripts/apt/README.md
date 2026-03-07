# apt

These are scripts i use related to apt and package management


## add-mirrors

Script to add mirrors to devuan and debian, it supports both the traditional sources style as well
as the DEB822 style sources, just create a file in `$XDG_CONFIG_HOME/devuan/mirrors`, like this:

```sh
# add url domains like this to append to the default devuan.org
# these will be expanded to a full url or a stanza depending on the sources style
urls="${urls} deb.devuan.nz"
urls="${urls} devuan.sedf.de"

# which type of sources should we generate
# available: traditional, modern, both
sources_type=modern
```


## apt-ui

A ui with fzf that wraps apt for many common package management actions, think of it like a TUI
synaptic, the configuration file is located at `$XDG_CONFIG_HOME/apt-ui/config.rc`, it contains:

```sh
# this is the command that will be used for the upgrade, purge and install actions
# by default: /usr/bin/apt-get
aptcmd=/usr/bin/apt
```

however you can also add options for fzf in this file, like so:

```sh
# this is the command that will be used for the upgrade, purge and install actions
# by default: /usr/bin/apt-get
aptcmd=/usr/bin/apt

FZF_COLORS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
--color=preview-bg:#44475a \
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4"

FZF_LAYOUT="--style=full:sharp"

export FZF_DEFAULT_OPTS="${FZF_COLORS} ${FZF_LAYOUT}"
```


## debdown

A script to download the .deb archive for the given package


## install-list.sh

A script to install lists of packages, useful when you do a minimal netinstall WITHOUT a DESKTOP
ENVIRONMENT and want to install your own lists of packages on top of the base devuan install, config
is located at `$XDG_CONFIG_HOME/install-list/proglist`

the following lists are available to override or append according to your preferences:

```sh
packages
zsh
console_prod
compression
min_setup
downloading
vifm
other
graphics_drivers
```

## list-upgradeable.sh

A wrapper for apt to show the upgradeable packages if any.
