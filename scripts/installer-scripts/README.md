# installer scripts

These are scripts to install some packages not available in the devuan repos


## additional-firmware

Script to download additional firmware blobs for amd from
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/amdgpu/


## brave-installer

Script to install the brave browser by adding the release repo onto the apt sources.


## discord installer

Script to fetch and install the latest discord .deb and install it, the configuration file is
located at `$XDG_CONFIG_HOME/discord-installer/configrc`, it contains:

```sh
# the discord channel to use for fetching the .deb archive, available options are: stable, canary
channel="stable"
```


## lazygit-installer

Script to fetch the latest release of lazygit and install it to `/usr/local/bin/`


## ttf-msvistafonts-installer

Script to fetch the true type microsoft vista fonts (calibri, cambria, consola, corbel) and install
them to `$XDG_DATA_HOME/fonts/ms-vista-fonts/`
