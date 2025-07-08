#!/usr/bin/env bash
set -euo pipefail

print_pass() { echo -e "✅ $1"; }
print_fail() {
	echo -e "❌ $1"
	exit 1
}
print_skip() { echo -e "⏭️  $1"; }

assert_cmd() {
	command -v "$1" >/dev/null 2>&1 && print_pass "$1 is installed" || print_fail "$1 is missing"
}

run_assertions() {
	echo "🧪 Running dotfiles post-install assertions..."

	# dotfiles binary symlink
	if [[ -x "$HOME/.local/bin/dotfiles" ]]; then
		print_pass "dotfiles binary is symlinked and executable"
	else
		print_fail "dotfiles binary not found or not executable at $HOME/.local/bin/dotfiles"
	fi

	# Homebrew check (macOS only)
	if [[ "$(uname -s)" == "Darwin" ]]; then
		command -v brew >/dev/null && print_pass "Homebrew is installed" || print_fail "Homebrew is not installed"
	else
		print_skip "Homebrew check skipped (non-macOS)"
	fi

	# .bash_profile.local check
	if [[ -f "$HOME/.bash_profile.local" ]]; then
		if grep -q "DOTFILES_DIR=" "$HOME/.bash_profile.local"; then
			print_pass "DOTFILES_DIR is defined in .bash_profile.local"
		else
			print_fail "DOTFILES_DIR is missing in .bash_profile.local"
		fi
	else
		print_fail ".bash_profile.local is missing"
	fi

	# Git config user.name and user.email
	git_name=$(git config --file "$HOME/.config/git/local" user.name || echo "")
	git_email=$(git config --file "$HOME/.config/git/local" user.email || echo "")

	[[ -n "$git_name" ]] && print_pass "Git user.name is set: $git_name" || print_fail "Git user.name is not set"
	[[ -n "$git_email" ]] && print_pass "Git user.email is set: $git_email" || print_fail "Git user.email is not set"

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

	# Font install check
	if [[ "$OSTYPE" == darwin* ]]; then
		FONT_DIR="$HOME/Library/Fonts"
	else
		FONT_DIR="$HOME/.local/share/fonts"
	fi

	if [[ -d "$FONT_DIR" ]]; then
		# use parentheses around `-o` clauses to ensure `find` groups them correctly
		font_files_count=$(find "$FONT_DIR" \( -iname '*.ttf' -o -iname '*.otf' \) -type f | wc -l)
		if ((font_files_count > 0)); then
			print_pass "Fonts installed in $FONT_DIR ($font_files_count files)"
		else
			print_fail "No font files (.ttf/.otf) found in $FONT_DIR"
		fi
	else
		print_skip "Font directory $FONT_DIR not found"
	fi

	# Check OPENAI_API_KEY is exported in .bash_profile.local
	if [[ -f "$HOME/.bash_profile.local" ]]; then
		if grep -q "^export OPENAI_API_KEY=" "$HOME/.bash_profile.local"; then
			print_pass "OPENAI_API_KEY is set in .bash_profile.local"
		else
			print_fail "OPENAI_API_KEY is not set in .bash_profile.local"
		fi
	else
		print_fail ".bash_profile.local is missing"
	fi

	# Check git hook for genmoji or gitmoji
	GIT_HOOK_PATH="$HOME/.config/git/hooks/prepare-commit-msg"
	if [[ -f "$GIT_HOOK_PATH" ]]; then
		if grep -qiE "(genmoji|gitmoji)" "$GIT_HOOK_PATH"; then
			print_pass "Git commit hook includes genmoji/gitmoji integration"
		else
			print_fail "Git commit hook at $GIT_HOOK_PATH does NOT include genmoji/gitmoji integration"
		fi
	else
		print_fail "Git commit hook $GIT_HOOK_PATH does not exist"
	fi

	echo "🎉 All assertions passed!"
}

run_assertions
