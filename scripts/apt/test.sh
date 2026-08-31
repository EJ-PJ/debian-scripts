
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

    if unzip "zip_file" -d "/home/${user}/.local/share/fonts/ttf/$file_name"; then
        echo "zip_file EXTRACTION WAS SUCCESFULL"
    else
        echo "ERROR WHILE EXTRACTING zip_file"
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


