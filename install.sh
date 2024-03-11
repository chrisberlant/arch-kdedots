#!/bin/bash

# Apps to install
apps=("neofetch" "visual-studio-code-bin" "chromium" "npm" "nodejs" "kitty" "zsh" "oh-my-zsh-git" "zsh-theme-powerlevel10k" "pokemon-colorscripts-git" "eza" "onlyoffice-bin")

# Function to check if a package is installed
package_installed() {
    pacman -Q "$1" &>/dev/null
}

# Loop on the apps array
for app in "${apps[@]}"; do
    if ! package_installed $app; then
        echo "Installing $app..."
        yay -S --noconfirm $app
        echo "$app installation completed."
    else
        echo "$app is already installed."
    fi
done


# Copy config files
echo "Creating config files..."
cp -r ./fonts ~/.local/share/
cp -r ./home/. ~/
cp -r ./config/. ~/.config
ln -s ~/.config/kitty/themes/Tokyo-Night.conf ~/.config/kitty/theme.conf
echo "Configuration finished."
