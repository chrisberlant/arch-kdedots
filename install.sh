#!/bin/bash

# Apps to install
apps=("neofetch" "visual-studio-code-bin" "chromium" "npm" "nodejs" "kitty" "zsh" "oh-my-zsh-git" "zsh-theme-powerlevel10k" "eza" "onlyoffice-bin")

# Function to check if a package is installed
package_installed() {
    pacman -Q "$1" &>/dev/null
}

# Check if git is installed
if ! package_installed 'git'; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git || { echo "Failed to install git."; }
else
    echo "Git is already installed."
fi

# Check if yay is installed
if ! package_installed 'yay'; then
    echo "Installing yay from AUR..."
    sudo pacman -S --needed --noconfirm base-devel || { echo "Failed to install base-devel."; }
    git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay."; exit 1; }
    cd yay && makepkg -si --noconfirm || { echo "Failed to build yay."; }
    cd .. && rm -rf yay || { echo "Failed to clean up yay directory."; }
    echo "Yay installation completed."
else
    echo "Yay is already installed."
fi

# Loop on the apps array
for app in "${apps[@]}"; do
    if ! package_installed $app; then
        echo "Installing $app..."
        yay -S --noconfirm $app || { echo "Failed to install $app."; }
    else
        echo "$app is already installed."
    fi
done

# Copy config files
echo "Creating config files..."
cp -r ./fonts ~/.local/share/ || { echo "Failed to copy fonts."; }
cp -r ./home/. ~/ || { echo "Failed to copy home files."; }
cp -r ./config/. ~/.config || { echo "Failed to copy config files."; }

# Ensure kitty theme directory exists before linking
if [[ -d ~/.config/kitty/themes ]]; then
    ln -sf ~/.config/kitty/themes/Tokyo-Night.conf ~/.config/kitty/theme.conf || { echo "Failed to create symlink for kitty theme."; }
else
    echo "Kitty themes directory not found, skipping theme configuration."
fi

# Change default shell to zsh
if [[ "$(echo $SHELL)" != "/usr/bin/zsh" ]]; then
    echo "Changing default shell to zsh..."
    chsh -s /usr/bin/zsh || { echo "Failed to change shell to zsh."; }
else
    echo "Zsh is already the default shell."
fi

# Install zsh plugins
echo "Configuring zsh plugins..."
ZSH_CUSTOM=/usr/share/oh-my-zsh/custom/plugins
if [[ ! -d $ZSH_CUSTOM ]]; then
    sudo mkdir -p $ZSH_CUSTOM || { echo "Failed to create zsh plugins directory."; }
fi

cd $ZSH_CUSTOM
sudo git clone https://github.com/chrissicool/zsh-256color || { echo "Failed to clone zsh-256color plugin."; }
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git || { echo "Failed to clone zsh-syntax-highlighting plugin."; }
sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git || { echo "Failed to clone zsh-autosuggestions plugin."; }

echo "Configuration completed. Please reboot your computer."
