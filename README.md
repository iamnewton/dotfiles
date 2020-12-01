# dotfiles(1)

Typically software you buy comes with some sort of installer, why not your dotfiles? After manually setting up my dotfiles and installation for years, I decided to take a page from [some](https://github.com/necolas) [other](https://github.com/mathiasbynens) [people's](https://github.com/cowboy) [books](http://dotfiles.github.io) and set up a script that will configure my machine to run [ViM as an IDE](http://blog.sanctum.geek.nz/series/unix-as-ide/).  Along the way, I figured how to get all of the necessary [Homebrew](http://braumeister.org) & [Node](https://www.npmjs.org) packages installed as well as some useful [Ruby gems](http://rubygems.org). Feel free to [poke around](https://github.com/iamnewton/dotfiles/commits/main) the repository, [fork it](https://github.com/iamnewton/dotfiles/fork) to make it your own, [suggest things](https://github.com/iamnewton/dotfiles/issues?labels=feature+request) for me to include, [log a bug](https://github.com/iamnewton/dotfiles/issues/new), or maybe checkout the [features list](#features) to see what's included.

**N.B.** This project has a [Code of Conduct](./.github/CODE_OF_CONDUCT.md). By interacting with this repository, organization, and/or community you agree to abide by its terms.

## Installation

:warning: This will overwrite existing dotfiles in your `$HOME` and `.vim` directories.

### Requirements

No matter which method you choose for installation, ensure that you have the following dependencies installed on your system.  If you're on MacOS then you already have these, but a Linux system may not come with all.

* [curl](http://curl.haxx.se)
* [git](http://git-scm.com)

If you use the [one-line installation](#one-line-install), no need to worry as it will handle all of the dependencies for you, so it's best advised to use, but the following are also required if you plan to manually install and run the CLI.

* [homebrew](http://brew.sh)
* [node](http://nodejs.org)
* [npm](https://www.npmjs.org)

:exclamation: N.B. [one-line installation](#one-line-install) will handle all of the dependencies for you, so it's best advised to use. Also note, [HTML Inspector](#node-packages) requires the full [xCode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12) installation, so choose accordingly when Homebrew asks you up front.

### One-line Install

```bash
$ /bin/bash -c "$(curl -#fL https://raw.githubusercontent.com/iamnewton/dotfiles/main/bin/install)"
```

:exclamation: N.B. If you wish to [fork this project](https://github.com/iamnewton/dotfiles/fork) and maintain your own dotfiles, you **MUST** substitute my username for your own in the above command and the variable (`$GITHUB_USER`) found at the top of the `bin/dotfiles` script.

## Options

| Flag              | Meaning                                |
| :-----------------| :------------------------------------- |
| `-b`, `--brew`    | Install the Homebrew formulae          |
| `-e`, `--edit`    | Edit the program                       |
| `-h`, `--help`    | Print help text                        |
| `--install`       | Install the setup library              |
| `-n`, `--npm`     | Install the NPM packages               |
| `--prefix`        | Print the installation directory       |
| `-s`, `--symlink` | Symlink all of the configuration files |
| `-t`, `--test`    | Run the test suite                     |
| `--upgrade`       | Upgrade and install dependencies       |
| `-v`, `--version` | Print the current version              |
| `--vim`           | Install ViM and plugins                |

## Man page

The man page is symlinked in the install process. As long as `$(brew --prefix)` (`/usr/local/bin` on MacOS and `/home/linuxbrew/.linuxbrew/bin` on Linux) is in your `$PATH`, then you should be able to access it via `man dotfiles`.

## Update

So it's time to update for [whatever reason](#when-to-update); don't fret, there is a command for that. Given everything is set up correctly, the following command should be available in your `$PATH`, meaning you can run from anywhere.

### How to update

```bash
$ dotfiles
```

### When to Update

* You want to pull changes from the remote repository
* You add a new Homebrew formulae, Ruby gems, Node packages.
* You want to update Homebrew formulae, Ruby gems, Node packages.

### Uninstall

If you need to uninstall for whatever reason, this script will remove all installed Homebrew formulae, Ruby Gems, Node and its packages, configuration symlinks, ViM and all of its plugins, and the library itself.  However, it won't uninstall Homebrew as I didn't want to make that assumption.

```bash
$ /bin/bash -c "$(curl -#fL https://raw.githubusercontent.com/iamnewton/dotfiles/main/bin/uninstall)"
```

## Features

Besides some [custom bash prompts](#shell-custom-bash-prompt), there are several package installations handled via Homebrew, Ruby gems, NPM, & Go that are listed in the [wiki](https://github.com/iamnewton/dotfiles/wiki). In addition, there are several ViM plugins that are installed via [Vundle](https://github.com/gmarik/vundle), and some `<tab>` completion libraries. If you want to modify what is installed by default, removing or adding is as easy as updating the package in the appropriate file.  Each package is stored in the `opt` directory and named for the package management software that is used.

:exclamation: N.B. Each package should be on a new line.

### Package Management libraries

* [Homebrew formulae](https://github.com/iamnewton/dotfiles/wiki/Homebrew)
* [~Ruby gems~](https://github.com/iamnewton/dotfiles/wiki/Ruby)
* [Node packages](https://github.com/iamnewton/dotfiles/wiki/Node)
* [~Go libraries~](https://github.com/iamnewton/dotfiles/wiki/Go)
* [ViM plugins](https://github.com/iamnewton/dotfiles/wiki/ViM)
* [&lt;tab&gt; Completion Libraries](https://github.com/iamnewton/dotfiles/wiki/-tab--Completion)

### Custom bash prompt

A custom bash prompt based on the [Seti UI color palette](https://github.com/jesseweed/seti-ui) and influenced by [@necolas](https://github.com/necolas), [@gf3](https://github.com/gf3) and [@cowboy](https://github.com/cowboy) custom prompts. When your current working directory is a Git repository, the `$PROMPT` will display the checked-out branch's name (and failing that, the commit SHA that `HEAD` is pointing to). The state of the working tree is reflected in the following way:

| Symbol | Meaning                          |
| :----: | :------------------------------- |
| +      | Uncommitted changes              |
| !      | Unstaged changes                 |
| ?      | Untracked files                  |
| $      | Stashed files                    |

For best results with iTerm, you should install [the SETI color scheme for iTerm](https://github.com/willmanduffy/seti-iterm). Further details are in the `$(dotfiles --prefix)/conf/bash/prompt` file.

#### Screenshot

![](https://iamnewton.github.io/cdn/images/dotfiles-screenshot-v2.png)

### Local/private Bash configuration

Any private and custom Bash commands and configuration should be placed in a `~/.bash_profile.local` file. This file will not be under version control or committed to a public repository. If `~/.bash_profile.local` exists, it will be sourced for inclusion in `bash_profile`.

Here is an example `~/.bash_profile.local`:

```bash
# Github Issues library token
export GHI_TOKEN="<insert github issues token>"

# Aliases
alias code="cd ~/Code"
```

:exclamation: N.B. Because the `$(dotfiles --prefix)/conf/git/config` file is copied to `$HOME/.gitconfig`, any private git configuration specified in `$HOME/.bash_profile.local` will not be committed to your dotfiles repository.

## Adding new ViM plugins

If you want to add more ViM plugins, to be managed by [Vundle](https://github.com/gmarik/Vundle.vim), then follow these steps while in the root of the superproject.

```bash
# Open Vundle
vim $(dotfiles --prefix)/vim/settings/bundles.vim
# Add new ViM bundle
Plugin 'chriskempson/base16-vim'
# Exit ViM, save and close all buffers
:xa
# Open ViM to source changes to vundle, install and quit
vim -u ${HOME}/.vim/settings/bundles.vim +PluginClean +PluginInstall +PluginUpdate +qa
```

## Adding new git submodules

If you want to add more git submodules, e.g., libraries not available through any package manager, then follow these steps while in the root of the superproject.

```bash
# Add the new submodule
git submodule add https://example.com/remote/path/to/repo.git [optional location]
# Initialize and clone the submodule
git submodule update --init
# Stage the changes
git add <submodule>
# Commit the changes
git commit -m "feat: add <submodule>"
```

## Updating git submodules

Updating individual submodules within the superproject:

```bash
# Change to the submodule directory
cd <path/to/submodule>
# Checkout the desired branch (of the submodule)
git checkout main
# Pull from the tip of main (of the submodule - could be any sha or pointer)
git pull origin main
# Go back to main dotfiles repo root
cd $(dotfiles --prefix)
# Stage the submodule changes
git add <path/to/submodule>
# Commit the submodule changes
git commit -m "feat: update '<submodule>' to the latest version"
# Push to a remote repository
git push origin main
```

Now, if anyone updates their local repository from the remote repository, then using `git submodule update` will update the submodules (that have been initialized) in their local repository.

:exclamation: N.B This will wipe away any local changes made to those submodules.

* * *

## Acknowledgements

Inspiration and code was taken from many sources, including (in lexicographical order):

* [@holman](https://github.com/holman) (Zach Holman) https://github.com/holman/dotfiles
* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens) https://github.com/mathiasbynens/dotfiles
* [@necolas](https://github.com/necolas) (Nicolas Gallagher) https://github.com/necolas/dotfiles

[vim-ctags]: http://andrew.stwrt.ca/posts/vim-ctags "Vim and Ctags"
