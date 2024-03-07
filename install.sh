#!/bin/bash

# Apps to install
apps=("neofetch" "visual-studio-code-bin" "chromium" "npm" "nodejs" "kitty" "zsh" "oh-my-zsh-git"  "zsh-theme-powerlevel10k" "pokemon-colorscripts-git" "eza")

# Function to check if a package is installed
package_installed() {
    pacman -Q "$1" &>/dev/null
}

# Loop over every apps
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

echo "Changing default shell to zsh..."
chsh -s /usr/bin/zsh

echo "Configuring zsh plugins..."
cd /usr/share/oh-my-zsh/custom/plugins
sudo git clone https://github.com/chrissicool/zsh-256color
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git

echo "Configuration completed. Please reboot your computer."