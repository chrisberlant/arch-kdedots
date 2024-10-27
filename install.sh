#!/bin/bash

# Apps to install
apps=("neofetch" "visual-studio-code-bin" "chromium" "npm" "nodejs" "kitty" "zsh" "oh-my-zsh-git" "zsh-theme-powerlevel10k" "eza" "onlyoffice-bin")

# Function to check if a package is installed
package_exists() {
    pacman -Q "$1" &>/dev/null
}

# Function to install a package
install_package() {
    if ! package_exists "$1"; then
        echo "Installing $1..."
        yay -S --noconfirm "$1" || { echo "Failed to install $1."; }
    else
        echo "$1 is already installed."
    fi
}

# Check if git is installed
if ! package_exists 'git'; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git || { echo "Failed to install git."; }
else
    echo "Git is already installed."
fi

# Check if yay is installed
if ! package_exists 'yay'; then
    echo "Installing yay from AUR..."
    sudo pacman -S --needed --noconfirm base-devel || { echo "Failed to install base-devel."; exit 1; }
    git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay."; exit 1; }
    cd yay || { echo "Failed to enter yay directory."; exit 1; }
    makepkg -si --noconfirm || { echo "Failed to build yay."; exit 1; }
    cd .. && rm -rf yay
    echo "Yay installation completed."
else
    echo "Yay is already installed."
fi

# Loop on the apps array
for app in "${apps[@]}"; do
    install_package "$app"
done

# Copy config files
echo "Creating config files..."
mkdir -p ~/.local/share/fonts
mkdir -p ~/.config
cp -r ./fonts ~/.local/share/ || { echo "Failed to copy fonts."; }
cp -r ./home/. ~/ || { echo "Failed to copy home files."; }
cp -r ./config/. ~/.config || { echo "Failed to copy config files."; }

# Ensure kitty theme directory exists before linking
mkdir -p ~/.config/kitty/themes
ln -sf ~/.config/kitty/themes/Tokyo-Night.conf ~/.config/kitty/theme.conf || { echo "Failed to create symlink for kitty theme."; }

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
