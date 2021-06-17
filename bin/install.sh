#!/usr/bin/env bash

# constants
readonly GITHUB_URL="github.com"
readonly USERNAME="iamnewton"
readonly REPO="dotfiles"
readonly LOG="/tmp/$REPO.install.log"
readonly INSTALL_DIR="$HOME/.$REPO"
OS="$(uname)"
readonly OS="${OS,,}"

# variables
GIT_AUTHOR_NAME=""
GIT_AUTHOR_EMAIL=""
GITHUB_TOKEN=""

# Question logging
print_question() {
	local message=$1

	echo "$(date) QUESTION:  $message" >> "$LOG"
	printf "\\n%s===> %s?%s " "$(tput setaf 3)" "$message" "$(tput sgr0)"
}

# Command/Processing logging
print_process() {
	local message=$1

	echo "$(date) PROCESSING: $message" >> "$LOG"
	printf "%s┃%s %s...\\n" "$(tput setaf 6)" "$(tput sgr0)$(tput setaf 7)" "$message$(tput sgr0)"
}

# Informational logging
print_info() {
	local message=$1

	echo "$(date) INFO: $message" >> $LOG
	printf "%sInfo:%s\\n" "$(tput setaf 6)" "$(tput sgr0) $message"
}

# Warning logging
print_warning() {
	local message=$1

	echo "$(date) WARNING: $message" >> "$LOG"
	printf "%s⚠ Warning:%s!\\n" "$(tput setaf 3)" "$(tput sgr0) $message"
}

# Error logging
print_error() {
	local message=$1

	echo "$(date) ERROR: $message" >> "$LOG"
	printf "%s⊘ Error:%s %s. Aborting!\\n" "$(tput setaf 1)" "$(tput sgr0)" "$message"
}

# Success logging
print_success() {
	local message=$1

	echo "$(date) SUCCESS: $message" >> "$LOG"
	printf "%s✓ Success:%s\\n" "$(tput setaf 2)" "$(tput sgr0) $message"
}

# @private
# @requires logger (local)
# @param $file - path to file where symlinks are listed out
link_it() {
	local file=$1
	# split input on space, and return 2nd part (the symbolic link desired)
	local symlink=($file)

	# Test whether a symbolic link already exists
	print_process "Checking if ${symlink[1]} is symlinked"
	if [[ ! -L "$HOME/${symlink[1]}" ]]; then
		# create an array of line items
		print_process "Symlinking ${symlink[0]}"
		ln -sfn "$INSTALL_DIR/${symlink[0]}" "$HOME/${symlink[1]}"
	else
		print_info "$HOME/${symlink[1]} is already symlinked. Skipping."
	fi
}

# @private
# @param $program - a function or program to process each item
# @param $file - path to a file with each item separated on a line
symlink() {
	local file=$1

	while IFS="" read -r p || [ -n "$p" ]
	do
		#printf '%s\n' "$p"
		link_it "$p"
	done < "$file"
}

# Check for Homebrew; install brew
if ! type -P 'brew' &> /dev/null; then
	print_process "Installing Homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# If we're on Linux, insert brew into the path temporarily to be able to use later
	if [[ "$OS" == "linux"  ]]; then
		print_process "Sourcing Homebrew to PATH"
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
		sudo apt-get install build-essential
		brew install gcc gpg node
	fi

	[[ $? ]] && print_success "Homebrew installed"
fi

# If missing, download and extract the dotfiles repository
if [[ ! -d "$INSTALL_DIR" ]]; then
	print_process "Creating directory at $INSTALL_DIR and setting permissions"
	mkdir -p "$INSTALL_DIR"

	print_process "Downloading repository to /tmp directory"
	# (-#) shows the progress bar as # sign
	# (-f) fail silently
	# (-L) follow the headers
	# (-o) output to a file
	curl -#fLo "/tmp/$REPO.tar.gz" "https://$GITHUB_URL/$USERNAME/$REPO/tarball/main"

	print_process "Extracting files to $INSTALL_DIR"
	tar -zxf "/tmp/$REPO.tar.gz" --strip-components 1 -C "$INSTALL_DIR"

	print_process "Removing tarball from /tmp directory"
	rm -rf "/tmp/$REPO.tar.gz"

	[[ $? ]] && print_success "$INSTALL_DIR created, repository downloaded and extracted"
fi

if command -v 'git' &> /dev/null; then
	# Change to the dotfiles directory
	cd "$INSTALL_DIR" || exit

	# Initialize the git repository if it's missing
	print_process "Initializing git repository"
	git init

	print_process "Adding https://$GITHUB_URL/$USERNAME/$REPO.git as origin"
	git remote add origin "https://$GITHUB_URL/$USERNAME/$REPO.git"

	print_process "Downloading changes from origin"
	git fetch origin main

	# Reset the index and working tree to the fetched HEAD
	# (submodules are cloned in the subsequent sync step)
	print_process "Resetting index & working tree to fetched HEAD"
	git reset --hard FETCH_HEAD

	# Remove any untracked files
	print_process "Removing any untracked files"
	git clean -fd

	[[ $? ]] && print_success "Repository has been initialized"

	# Pull down the latest changes
	print_process "Pulling down latest changes"
	git pull --rebase origin main

	[[ $? ]] && print_success "Repository has been updated"
fi

if [[ ! -f "$HOME/.bash_profile.local" ]]; then
	print_process "Copying local bash_profile template to $HOME"
	echo '#!/usr/bin/env bash' >> "$HOME/.bash_profile.local"
fi

# Force remove the git templates directory if it's already there.
if [ -e "$HOME/.templates" ]; then
	print_process "Removing $HOME/.templates/ directory"
	rm -rf "$HOME/.templates"
fi

# Create the necessary symbolic links between the `.dotfiles` and `HOME`
# directory. The `bash_profile` sources other files directly from the
# `.dotfiles` repository.
if [[ -f "$INSTALL_DIR/opt/symlinks" ]]; then
	print_process "Symlinking configuration files"
	symlink "$INSTALL_DIR/opt/symlinks"
	link_it "conf/misc/tmux.$OS .tmux.conf"

	[[ $? ]] && print_success "Symlinked configuration files"
fi

# Copy `.ssh/config`.
# This prevents them being committed to the repository.
print_process "Syncing global ssh configuration file"
mkdir -p "$HOME/.ssh"
cp "$INSTALL_DIR/conf/ssh/config.$OS"  "$HOME/.ssh/config"

if command -v 'curl' &> /dev/null; then
	# Setup git authorship
	print_process "Setting up netrc"
	# Git author name
	print_question "What's your GitHub personal token? Create a token at <https://github.com/settings/applications#personalaccess-tokens>"
	read -r USER_GITHUB_TOKEN
	if [[ -n "$USER_GITHUB_TOKEN" ]]; then
		GITHUB_TOKEN="$USER_GITHUB_TOKEN"

		printf "machine api.github.com\n\tlogin $GITHUB_TOKEN\n\tpassword x-oauth-basic\n\n' >> $HOME/.netrc"
		printf "machine raw.githubusercontent.com\n\tlogin $GITHUB_TOKEN\n\tpassword x-oauth-basic' >> $HOME/.netrc"

		[[ $? ]] && print_success "netrc was created succesfully"
	else
		print_warning "No GitHub token was created.  Please update manually"
	fi
fi

if command -v 'git' &> /dev/null; then
	# Setup git authorship
	print_process "Setting up Git author"
	# Git author name
	print_question "What's your name"
	read -r USER_GIT_AUTHOR_NAME
	if [[ -n "$USER_GIT_AUTHOR_NAME" ]]; then
		GIT_AUTHOR_NAME="$USER_GIT_AUTHOR_NAME"
		git config --file "$HOME/.gitconfig.local" user.name "$GIT_AUTHOR_NAME"

		[[ $? ]] && print_success "Git username is $(git config user.name)"
	else
		print_warning "No Git user name has been set.  Please update manually"
	fi

	# Git author email
	print_question "What's your email"
	read -r USER_GIT_AUTHOR_EMAIL
	if [[ -n "$USER_GIT_AUTHOR_EMAIL" ]]; then
		GIT_AUTHOR_EMAIL="$USER_GIT_AUTHOR_EMAIL"
		git config --file "$HOME/.gitconfig.local" user.email "$GIT_AUTHOR_EMAIL"

		[[ $? ]] && print_success "Git email is $(git config user.email)"
	else
		print_warning "No Git user email has been set.  Please update manually"
	fi

	[[ $? ]] && print_success "Git author is $(git config user.name) <$(git config user.email)>"
fi

# Setup GPG
# https://help.github.com/articles/generating-a-new-gpg-key/
if type -P 'gpg' &> /dev/null; then
	print_process "Generating a GPG key"
	# generate a new GPG key
	# then if successful, list out the keys
	gpg --gen-key && gpg --list-secret-keys --keyid-format LONG

	print_question "Which GPG key would you like to copy? (choose the code on the 'sec' line after the first slash)"
	read -r USER_GIT_GPG_KEY

	if [[ -n "$USER_GIT_GPG_KEY" ]]; then
		GIT_GPG_KEY="$USER_GIT_GPG_KEY"
		print_process "Copying GPG key to pasteboard"
		git config --file "$HOME/.gitconfig.local" user.signingkey "$GIT_GPG_KEY"
		if [[ "$OS" == "darwin" ]]; then
			# only works on MacOS
			gpg --armor --export "$GIT_GPG_KEY" | pbcopy
			open "https://$GITHUB_URL/settings/keys"
		else
			gpg --armor --export "$GIT_GPG_KEY"
			print_process "Open Github settings <https://$GITHUB_URL/settings/keys>; create a new GPG key and paste in the pasteboard"
		fi
	else
		print_warning "No GPG key has been set.  Please update manually"
	fi
fi

# Check for brew bash; change to it
print_process "Changing login shell to Homebrew installed version"

# Mac OS X directory service command line utility
# sudo dscl . -change /Users/$USER UserShell /bin/bash /usr/local/bin/bash
if [[ "$OS" == "darwin" ]]; then
	echo "$(brew --prefix)/bin/bash" | pbcopy
	print_process "Copied brew's /bin/bash to pasteboard"

	print_process "Opening ViM to update /etc/shells with brew's /bin/bash"
	# `vim +` runs vim and puts you at the last line of the file
	# -c allows you to run commands and you can have up to 10
	# process reads => open /etc/shells in ViM, go to the last line, put
	# in Insert mode, paste in from the pasteboard, close and save all
	sudo vim + -c 'startinsert' -c ':r !pbpaste' -c ':xa' /etc/shells
fi

if [[ "$OS" == "linux" ]]; then
	# Programmatic way to change shell
	sudo chsh -s "$(brew --prefix)/bin/bash" 2>/dev/null
fi

[[ $? ]] && print_success "Changed default shell to Homebrew installed version"

print_process "Sourcing $HOME/.bash_profile"
# shellcheck source=/dev/null
source "$HOME/.bash_profile" 2&>/dev/null

[[ $? ]] && print_success "Dotfiles installed.  To upgrade, run dotfiles"
