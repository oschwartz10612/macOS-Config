#!/bin/sh

if test ! $(which brew); then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo "Updating brew..."
brew update

PACKAGES=(
avrdude
clamav
cmake
gnupg
htop
paperkey
platformio
rename
ruby
unrar
wget
python
node
poppler
gcc
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup

echo "Installing brew cask..."
brew install homebrew/caskroom

CASKS=(
android-platform-tools
arduino
firefox
google-cloud-sdk
maccy
prusaslicer
rectangle
skype
teamviewer
google-chrome
autodesk-fusion360
visual-studio-code
slack
appcleaner
balenaetcher
docker
bartender
discord
electrum
eagle
istat-menus
meshmixer
vlc
virtualbox
tunnelblick
ti-connect-ce
steam
spotify
private-internet-access
postman
obs
mos
iterm2
microsoft-office
tor-browser
unity-hub
zoomus
)

echo "Installing cask apps..."
brew cask install ${CASKS[@]}