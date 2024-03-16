# arch-kdedots

Dots for KDE Plasma on Arch Linux

## Installation

After an Arch install (or EndeavourOs)

### You need to have yay and git installed (included with EOS)

```shell
git clone https://aur.archlinux.org/yay.git yay
```

```shell
cd yay
```

```shell
makepkg -si
```

```shell
pacman -Sy git
```

### Clone the repository

```shell
git clone --depth 1 https://github.com/chrisberlant/arch-kdedots ~/kdedots
```

### Execute the installation as standard user, NOT as root

```shell
cd ~/kdedots
```

```shell
./install.sh
```
