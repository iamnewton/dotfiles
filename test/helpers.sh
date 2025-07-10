#!/usr/bin/env bash
set -euo pipefail

# Print helpers
print_pass() { echo -e "\t✅ $1"; }
print_fail() { echo -e "\t❌ $1"; }
print_skip() { echo -e "\t⏭️  $1"; }

# Track it failures
failures=0

# it wrapper
it() {
	local description="$1"
	shift
	if "$@"; then
		print_pass "$description"
	else
		print_fail "$description"
		failures=$((failures + 1))
	fi
}

describe() {
	echo -e "\n📂 $1"
}

# Assertions
assert_cmd() {
	local cmd="$1"
	it "$cmd is installed" command -v "$cmd" >/dev/null 2>&1
}

assert_file() {
	local path="$1"
	it "$path exists" test -f "$path"
}

assert_dir() {
	local path="$1"
	it "$path directory exists" test -d "$path"
}

assert_symlink() {
	local path="$1"
	local expected_target="${2:-}"

	# Check if path is a symlink
	it "$path is a symlink" test -L "$path"

	# If expected target provided, check symlink points correctly
	if test -n "$expected_target"; then
		local actual_target
		actual_target=$(readlink "$path")
		it "$path points to $expected_target" test "$actual_target" = "$expected_target"
	fi
}

assert_equals() {
	local a="$1"
	local b="$2"
	it "$a is set: $b" test "$a" = "$b"
}

assert_variable() {
	local variable="$1"
	local label="$2"
	it "$label is set: $variable" test -n "$variable"
}

assert_file_contains() {
	local file="$1"
	local pattern="$2"

	# First assert the file exists
	if assert_file "$file"; then
		# Only if file exists, check if pattern is found
		it "$pattern is defined in $file" grep -q "$pattern" "$file"
	else
		print_fail "File $file not found, cannot check pattern $pattern"
	fi
}
