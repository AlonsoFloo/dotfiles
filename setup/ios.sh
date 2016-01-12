if [[ ! "$(which brew)" ]]; then
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

#Needed packages
brew install highlight fortune cowsay


#Disable the dashboard
defaults write com.apple.dashboard mcx-disabled -boolean YES
#Speed up dock show/hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.5
killall Dock

#Change screenshot location
mkdir -p ~/Desktop/Screenshots
defaults write com.apple.screencapture location ~/Desktop/Screenshots/
killall SystemUIServer

#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true
#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true
#Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
#Show the ~/Library folder
chflags nohidden ~/Library
# New windows show home directory.
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Show icons on the desktop for external disks.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -boolean true
# Show icons on the desktop for removable media.
defaults write com.apple.finder ShowRemovableMediaOnDesktop -boolean true
killall Finder
	
# Set highlight color to green
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
	
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
	
# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
	
# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
	
# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
	
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true