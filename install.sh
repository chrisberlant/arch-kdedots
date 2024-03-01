#!/bin/bash

# Function to check if a package is installed
package_installed() {
    pacman -Q "$1" &>/dev/null
}

# Chromium
if ! package_installed chromium; then
    echo "Installing Chromium..."
    pacman -S --noconfirm chromium
	echo "Chromium installation completed."
else
    echo "Chromium is already installed."
fi

# VSCode
if ! package_installed visual-studio-code-bin; then
    echo "Installing VSCode..."
    yay -S --noconfirm visual-studio-code-bin
	echo "VSCode installation completed."
else
    echo "VSCode is already installed."
fi

# NPM
if ! package_installed npm; then
    echo "Installing NPM..."
    pacman -S --noconfirm npm
	echo "NPM installation completed."
else
    echo "NPM is already installed."
fi

# NodeJS
if ! package_installed chromium; then
    echo "Installing NodeJS..."
    pacman -S --noconfirm nodejs
	echo "NodeJS installation completed."
else
    echo "NodeJS is already installed."
fi


# Kitty
if ! package_installed kitty; then
    echo "Installing Kitty..."
    pacman -S --noconfirm kitty
	echo "Kitty installation completed."
else
    echo "Kitty is already installed."
fi

# Zsh
if ! package_installed zsh; then
    echo "Installing Zsh..."
    pacman -S --noconfirm zsh
	echo "Zsh installation completed."
else
    echo "Zsh is already installed."
fi

# Oh-my-zsh
if ! package_installed oh-my-zsh-git; then
    echo "Installing Oh-my-zsh..."
    yay -S --noconfirm oh-my-zsh-git
	echo "Oh-my-zsh installation completed."
else
    echo "Oh-my-zsh is already installed."
fi

# Powerlevel10k
if ! package_installed zsh-theme-powerlevel10k; then
    echo "Installing Powerlevel10k..."
    pacman -S --noconfirm oh-my-zsh-git
	echo "Powerlevel10k installation completed."
else
    echo "Powerlevel10k is already installed."
fi

# Pokemon-colorscripts
if ! package_installed pokemon-colorscripts-git; then
    echo "Installing Pokemon-colorscripts..."
    yay -S --noconfirm pokemon-colorscripts-git
	echo "Pokemon-colorscripts installation completed."
else
    echo "Pokemon-colorscripts is already installed."
fi

# Neofetch
if ! package_installed neofetch; then
    echo "Installing Neofetch..."
    pacman -S --noconfirm neofetch
	echo "Neofetch installation completed."
else
    echo "Neofetch is already installed."
fi





# Copy config files
echo "Creating config files..."
cp -r ./fonts ~/.local/share/
cp -r ./home/. ~/
cp -r ./config/. ~/.config
ln -s ~/.config/kitty/themes/Tokyo-Night.conf ~/.config/kitty/theme.conf