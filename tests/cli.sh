#!/usr/bin/env roundup
# shellcheck shell=bash

dotfiles="./bin/dotfiles"

describe "cli"

it_shows_help() {
	$dotfiles --help | grep "usage: dotfiles"
}
it_shows_a_version() {
	$dotfiles --version | grep "Version"
}
it_prints_the_install_directory() {
	status=$(set +e ; $dotfiles --prefix >/dev/null ; echo $?)
	test 0 -eq "$status"
}
it_shows_usage_after_invalid_option() {
	$dotfiles --asdf | grep "usage: dotfiles"
}
