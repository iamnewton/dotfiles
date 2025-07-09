#!/usr/bin/env bash
set -euo pipefail

# Import test helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/helpers.sh"

readonly OS="$(uname | tr '[:upper:]' '[:lower:]')"
readonly REPO="dotfiles"
readonly INSTALL_DIR="$HOME/.local/lib/$REPO"
readonly DOTFILES_BIN="$HOME/.local/bin/$REPO"

run_assertions() {
	echo "🧪 Running dotfiles post-install assertions..."

	describe "$REPO setup"
	# check for homebrew installation
	assert_cmd brew
	# Check install directory exists
	assert_dir "$INSTALL_DIR"
	# Check install directory is git initialized
	assert_dir "$INSTALL_DIR/.git"
	# Check binary is executable
	assert_symlink "$DOTFILES_BIN" "$INSTALL_DIR/bin/${REPO}"

	describe "Configuration setup"
	# Check dotconfig symlinks
	for filepath in "$INSTALL_DIR/conf"/*; do
		[[ -f "$filepath" ]] || continue
		local filename target
		filename="$(basename "$filepath")"
		target="$HOME/.$filename"
		assert_symlink "$target" "$filepath"
	done
	# Check OS file symlinks
	assert_file "$HOME/.ssh/config"
	assert_symlink "$HOME/.tmux.conf" "$INSTALL_DIR/lib/tmux/$OS"
	# Check config symlinks
	for item in "$INSTALL_DIR/share/config"/*; do
		[[ -e "$item" ]] || continue
		local name target
		name="$(basename "$item")"
		target="$HOME/.config/$name"
		assert_symlink "$target" "$item"
	done
	# Check bash_profile.local contents
	assert_file_contains "$HOME/.bash_profile.local" "DOTFILES_DIR="

	describe "Tools setup & installation"
	# Check homebrew package installations
	# Check whalebrew package installations
	# Check npm package installations
	packages=(fkill-cli fx-completion is-up tldr trash vtop)
	for pkg in "${packages[@]}"; do
		assert_cmd "$pkg"
	done
	# Check for font installs
	if [[ "$OS" == darwin ]]; then
		FONT_DIR="$HOME/Library/Fonts"
	else
		FONT_DIR="$HOME/.local/share/fonts"
	fi
	assert_dir "$FONT_DIR"
	for font_file in "$FONT_DIR"/*.{ttf,otf}; do
		assert_file "$font_file"
	done
	# Check for LS colors
	assert_file_contains "$HOME/.config/dircolors" "LS_COLORS="
	# Check for genmoji
	assert_cmd genmoji
	assert_file_contains "$HOME/.bash_profile.local" "OPENAI_API_KEY="

	assert_cmd gitmoji-fuzzy-hook-init
	assert_file_contains "$HOME/.config/git/hooks/prepare-commit-msg" "gitmoji-fuzzy-hook"
	assert_file_contains "$HOME/.config/git/templates/hooks/prepare-commit-msg" "gitmoji-fuzzy-hook"

	describe "Authorship setup"
	# Git token
	assert_file_contains "$HOME/.netrc" "github"
	assert_file_contains "$HOME/.bash_profile.local" "GITHUB_TOKEN="
	# Git config user.name and user.email
	git_name=$(git config --file "$HOME/.config/git/local" user.name || echo "")
	git_email=$(git config --file "$HOME/.config/git/local" user.email || echo "")
	assert_variable $git_name "Git user.name"
	assert_variable $git_email "Git user.email"
	assert_file_contains "$HOME/.bash_profile.local" "GITHUB_AUTHOR_NAME="
	assert_file_contains "$HOME/.bash_profile.local" "GITHUB_AUTHOR_EMAIL="

	# GPG directory permissions
	GNUPGHOME="${GNUPGHOME:-$HOME/.config/gnupg}"
	# Follow symlink to actual target
	real_gnupghome=$(readlink -f "$GNUPGHOME" 2>/dev/null || echo "$GNUPGHOME")

	if [[ -d "$real_gnupghome" ]]; then
		# Get permission as octal string
		perms=$(stat -c '%a' "$real_gnupghome" 2>/dev/null || stat -f '%Lp' "$real_gnupghome")

		# Convert string to base-8 number for bitwise operations in bash arithmetic
		perm_num=$((8#$perms))
		# Check if group and others have permissions (bits 0o77)
		if (((perm_num & 077) == 0)); then
			print_pass "GPG directory is secured (permissions $perms)"
		else
			print_fail "GPG directory permissions are $perms, expected 700 (no group/other perms)"
		fi
	else
		print_skip "GPG directory not found at $real_gnupghome"
	fi

	assert_equals $SHELL $(brew --prefix)/bin/bash
	echo "🎉 All assertions passed!"
}

run_assertions

exit $failures
