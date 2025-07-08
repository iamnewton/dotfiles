#!/usr/bin/env bash
set -euo pipefail

# Print helpers
print_pass() { echo -e "✅ $1"; }
print_fail() { echo -e "❌ $1"; }
print_skip() { echo -e "⏭️  $1"; }

# Track test failures
failures=0

# Test wrapper
test() {
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
	test "\t$cmd is installed" command -v "$cmd" >/dev/null 2>&1
}

assert_file() {
	local path="$1"
	test "\t$path exists" [[ -f "$path" ]]
}

assert_dir() {
	local path="$1"
	test "\t$path directory exists" [[ -d "$path" ]]
}

assert_symlink() {
	local path="$1"
	local expected_target="${2:-}"

	# Check if path is a symlink
	test "$path is a symlink" [[ -L "$path" ]]

	# If expected target provided, check symlink points correctly
	if [[ -n "$expected_target" ]]; then
		local actual_target
		actual_target=$(readlink "$path")
		test "$path points to $expected_target" [[ "$actual_target" == "$expected_target" ]]
	fi
}

assert_file_contains() {
	local file="$1"
	local pattern="$2"
	test "\t$pattern is defined in $file" grep -q "$pattern" "$file"
}
