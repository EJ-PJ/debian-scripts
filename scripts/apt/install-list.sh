#!usr/bin/bash

#################################################################################
#### a configurable script to quickly install or reinstall lists of packages ####
#################################################################################

myname=${0##*/}

packages="
accountsservice
network-manager
lm-sensors
fancontrol
poppler-utils
atool
pipewire
pipewire-pulse
pipewire-jack
pipewire-alsa
pipewire-audio
wireplumber
"

other="
upower
pkexec
btrfs-progs
redshift
nemo
"

flatpak="
flatpak
"

vifm="
trash-cli
dosfstools
pkexec
vifm
"

zsh="
bash-completion
zsh
zsh-autosuggestions
zsh-syntax-highlighting
"

compression="
tar
zip
zstd
archivemount
7zip
p7zip-full
bzip2
unzip
"

downloading="
curl
aria2
wget
megatools
yt-dlp
"

min_setup="
yad
gparted
arandr
alacritty
brightnessctl
fonts-noto
fonts-noto-color-emoji
papirus-icon-theme
mpv
vlc
picom
rofi
pulseaudio-utils
copyq
copyq-plugins
flameshot
xinput
xclip
python3-dbus
zathura
zathura-pdf-poppler
network-manager-gnome
pavucontrol
"

console_prod="
python3-pip
python3-venv
python3-build
pipx
build-essential
netcat-openbsd
inxi
ffmpeg
fastfetch
mediainfo
python3-pynvim
calcurse
w3m
shellcheck
git
python3-libtmux
btop
fzf
imagemagick
psmisc
jq
ncdu
lua5.1
taskwarrior
"

# return type: string
get_header_comment () {
    sed -n '/^#### /p' "$0" | sed 's/^#### /\t/ ; s/ ####$//'
}

show_usage () {
    printf '%s\n'   "Usage:"
    printf '\t%s\n' "${myname} debug | help | install [LIST] | reinstall [LIST]"
}

# Usage: show_help
show_help () {
    printf '%s\n'   "${myname}"
    get_header_comment
    show_usage
    printf '%s\n'   "[LIST]:"
    printf '\t%s\n' "the list of programs to install/reinstall, you can pass the list 'all'"
    printf '\t%s\n' "to install the programs from all the lists or a specific list"
    printf '\t%s\n' "the following lists are available:"
    printf '\t\t%-18s\t%-18s\n' "####   Var   ####" "####   Arg   ####"
    printf '\t\t%-18s\t%-18s\n' "\$packages" "packages"
    printf '\t\t%-18s\t%-18s\n' "\$zsh" "zsh"
    printf '\t\t%-18s\t%-18s\n' "\$console_prod" "console-prod"
    printf '\t\t%-18s\t%-18s\n' "\$compression" "compression"
    printf '\t\t%-18s\t%-18s\n' "\$min_setup" "min-setup"
    printf '\t\t%-18s\t%-18s\n' "\$downloading" "downloading"
    printf '\t\t%-18s\t%-18s\n' "\$vifm" "vifm"
    printf '\t\t%-18s\t%-18s\n' "\$other" "other"
    printf '\t\t%-18s\t%-18s\n' "\$flatpak" "flatpak"
    printf '\t%s\n' "to modify the lists write a file to \$XDG_CONFIG_HOME/install-list/proglist"
    printf '\t%s\n' "and inside write the modified program lists in one of the following formats:"
    printf '\t%s\n' "to append to the default lists:"
    printf '\t\t%s\n' "packages=\"\${packages} emacs ffmpeg\""
    printf '\t%s\n' "to overwrite the default lists:"
    printf '\t\t%s\n' "packages=\"emacs ffmpeg\""
    printf '\t%s\n' "besides the modifiable lists there exists some special lists that can be"
    printf '\t%s\n' "passed as arguments:"
    printf '\t\t%-18s\t%s\n' "all" "- all the lists"
}

nerd_fonts () {
  user=$(logname)

	# Creating .local/user/share/fonts directory
	if [ -d "/home/${user}/.local/share/fonts" ]; then
		echo "FONTS DIRECTORY ALREADY EXISTS. IGNORING CREATION"
	else
		echo "FONTS DIRECTORY DOES NOT EXISISTS..."
		echo "A /home/${user}/.local/share/fonts creation will be made..."
		mkdir -p "/home/${user}/.local/share/fonts"
	fi

	# Creating .local/user/share/fonts/otf
	if [ -d "/home/${user}/.local/share/fonts/otf" ]; then
		echo "OTF DIRECTORY ALREADY EXISTS. IGNORING CREATION"
	else
		echo "OTF DIRECTORY DOES NOT EXISISTS..."
		echo "A /home/${user}/.local/share/fonts/otf creation will be made..."
		mkdir -p "/home/${user}/.local/share/fonts/otf"
	fi

	# Creating .local/user/share/fonts/ttf
	if [ -d "/home/${user}/.local/share/fonts/ttf" ]; then
		echo "TTF DIRECTORY ALREADY EXISTS. IGNORING CREATION"
	else
		echo "TTF DIRECTORY DOES NOT EXISISTS..."
		echo "A /home/${user}/.local/share/fonts/ttf creation will be made..."
		mkdir -p "/home/${user}/.local/share/fonts/ttf"
	fi

    font_name=( "Mononoki" "JetBrainsMono" "FiraCode")
    font_file_names=("MononokiNerdFont" "JetBrainsMono" "FiraCode")
    font_url=(
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/Mononoki.zip"
        "https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip"
        "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.5.1/FiraCode.zip"
    )

    # Creating Nerf Font Files
    echo "MAKING NERD FONT FILES..."
    for file_name in "${font_file_names[@]}"; do

        echo "CREATING $file_name FILE..."

        # Probes if the file_name already exists
        if [ -d "/home/${user}/.local/share/fonts/ttf/$file_name" ]; then
            echo "$file_name DIRECTORY ALREADY EXISTS. IGNORING CREATION"
            echo "It will be assumed that this font is already install"
            echo "Skipping font installation..."
            continue
        fi

        echo "$file_name DIRECTORY DOES NOT EXIST..."
        echo "A /home/${user}/.local/share/fonts/ttf/$file_name creation will be created..."

        if mkdir -p "/home/${user}/.local/share/fonts/ttf/$file_name"; then
            echo "$file_name DIRECTORY CREATED SUCCESFULLY"
        else
            echo "ERROR WHILE TRYING TO CREATE $file_name DIRECTORY"
            echo "STOPING PROCESS"
            return 1
        fi
    done

    echo "DOWNLOADING FONTS... "

    for i in "${!font_name[@]}"; do
        name="${font_name[$i]}"
        url="${font_url[$i]}"
        if wget "$url"; then
            echo "$name FONT DOWNLOAD SUCCESFULL"
        else
            echo "ERROR: FAILED TO DOWNLOAD $name FONT"
            return 1
        fi
    done

    for i in "${!font_name[@]}"; do
        url="${font_url[$i]}"
        file_name="${font_file_names[$i]}"

        zip_file="${url##*/}"

        echo "EXTRACTING $zip_file..."

        if unzip "$zip_file" -d "/home/${user}/.local/share/fonts/ttf/$file_name"; then
            echo "zip_file EXTRACTION WAS SUCCESFULL"
        else
            echo "ERROR WHILE EXTRACTING $zip_file"
            echo "STOPING PROCESS"
            return 1
        fi
    done

    for i in "${!font_name[@]}"; do
        name="${font_name[$i]}"
        file_name="${font_file_names[$i]}"

        zip_file="${url##*/}"

        echo "REMOVING $zip_file..."

        if rm -f "$zip_file"; then
            echo "$zip_file REMOVE WAS SUCCESFULL"
        else
            echo "ERROR WHILE REMOVE $zip_file"
            echo "STOPING PROCESS"
            return 1
        fi

        echo "$name FONT INSTALLATION WAS SUCCESFULL"
    done

	# Executing fc-cache for install fonts
	echo "fc-cache WILL BE EXECUTE"
	echo "EXECUTING fc-cache..."
	if fc-cache -v;then
	    echo "EXECUTION fc-cache WAS SUCCESFULL"
    else
	    echo "ERROR while fc-cache EXECUTION"
        return 1
    fi

    return 0
}

install_pywal16 () {
	echo "Pywal16 it will be install..."
	echo "EXECUTING PIPX FOR PYWAL16"
    if pipx install pywal16; then
        echo "PYWAL16 DOWNLOAD SUCCESSFUL!"
    else
        echo "ERROR: FAILED TO DOWNLOAD PYWAL16"
        return 1
    fi

    return 0
}

install_nvim() {

    echo "NEOVIM V0.11.5 WILL BE INSTALLED..."
    echo "DOWNLOADING NEOVIM V0.11.5"

    if ! wget --progress=bar:force:noscroll \
        "https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz"
    then
        echo "ERROR: FAILED TO DOWNLOAD NEOVIM"
        return 1
    fi

    echo "EXTRACTING nvim-linux-x86_64.tar.gz"

    if ! sudo rm -rf "/opt/nvim-linux-x86_64"; then
        echo "ERROR: FAILED TO REMOVE OLD NEOVIM INSTALLATION"
        return 1
    fi

    if ! sudo tar -C "/opt" -xzf "nvim-linux-x86_64.tar.gz"; then
        echo "ERROR: FAILED TO EXTRACT NEOVIM"
        exit 1
    fi

    if ! printf '\nexport PATH="$PATH:/opt/nvim-linux-x86_64/bin"\n' >> "$HOME/.zshrc"; then
        echo "ERROR: FAILED TO UPDATE .zshrc"
        exit 1
    fi

    echo "NEOVIM INSTALLATION SUCCESSFUL"

    return 0
}

configdir="${XDG_CONFIG_HOME:-$HOME/.config}"

UserID=$(id -u)
LocalUserID=$(id -u "$(logname)")
# this will usually be used with sudo so we have to load the correct file
if [ "$UserID" -eq 0 ]; then
    # seems we are root
    # are we really root tho?
    if [ "$UserID" -ne "$LocalUserID" ]; then
        # not actual root
        # get local user name
        user=$(logname)
        # if this is not your actual config dir then get rekt
        configdir="/home/${user}/.config"
    fi
fi

uselists="${configdir}/install-list/proglist"

if [ -f "$uselists" ]; then
    # yep, we do NOT check the contents just source them blindly
    # if the user wrote something bad it is his problem~~
    . "$uselists"
fi


case ${1} in
		# Prints packages to be installed
    debug)
        echo "the following packages are to be installed:"
        echo "general:"
        echo $packages
        echo "zsh:"
        echo $zsh
        echo "console productivity:"
        echo $console_prod
        echo "compression:"
        echo $compression
        echo "minimal setup:"
        echo $min_setup
        echo "downloading:"
        echo $downloading
        echo "vifm:"
        echo $vifm
        echo "devuan:"
        echo "others:"
        echo $other
        echo "flatpak support:"
        echo $flatpak
    ;;
    install|reinstall)
        if [ -z "$2" ]; then
            echo "no packages selected!!!!"
            echo "select from the following list:"
            echo "    packages"
            echo "    zsh"
            echo "    console_prod"
            echo "    compression"
            echo "    min_setup"
            echo "    downloading"
            echo "    vifm"
            echo "    other"
            echo "    flatpak"
            echo "    nerd-fonts"
			echo "    nvim (v0.11.5)"
            exit 1
        fi
        apt_act="$1"
  			case $2 in
            all)
                tosintall="
                $packages
                $zsh
                $console_prod
                $compression
                $min_setup
                $downloading
                $vifm
                $other
                $flatpak
                "
                apt $apt_act $tosintall
			   # nerd_fonts
			    install_pywal16
                nvim
            ;;
            debian|ubuntu|nodevuan)
                tosintall="
                $packages
                $zsh
                $console_prod
                $compression
                $min_setup
                $downloading
                $vifm
                $other
                "
                apt $apt_act $tosintall
				nerd_fonts
			    install_pywal16
                install_nvim
            ;;
            general)
                apt $apt_act $packages
            ;;
            zsh)
                apt $apt_act $zsh
            ;;
            console|console-prod|console_prod)
                apt $apt_act $console_prod
            ;;
            compression|comp|zip|rar)
                apt $apt_act $compression
            ;;
            min-setup)
                apt $apt_act $min_setup
            ;;
            downloading|curl|megatools|download|dld)
                apt $apt_act $downloading
            ;;
            vifm)
                apt $apt_act $vifm
            ;;
            other)
                apt $apt_act $other
            ;;
            flatpak)
                apt $apt_act $flatpak
            ;;
            nerd-fonts)
				nerd_fonts
            ;;
			nvim)
			    install_nvim
            ;;
            *)
                echo "unknown package list $2"
                show_help
                exit 1
            ;;
        esac
    ;;
    -h|--help|help)
        show_help
    ;;
    *)
        echo "no option chosen, use debug, install or reinstall."
        show_usage
        exit 1
    ;;
esac
