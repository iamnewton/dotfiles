# dotfiles

Typically software you buy comes with some sort of installer, why not your dotfiles? After setting up my dotfiles and installation for years, I decided to take a page from [some](https://github.com/necolas) [other](https://github.com/mathiasbynens) [people's](https://github.com/cowboy) [books](http://dotfiles.github.io) and set up a script that will configure my machine to run [ViM as an IDE](http://blog.sanctum.geek.nz/series/unix-as-ide/).  Along the way, I figured how to get all of the necessary [Homebrew](http://braumeister.org) & [Node](https://www.npmjs.org) packages installed as well as some useful [Ruby gems](http://rubygems.org). Feel free to [poke around](https://github.com/chrisopedia/dotfiles/commits/master) the repository, [fork it](https://github.com/chrisopedia/dotfiles/fork) to make it your own, [suggest things](https://github.com/chrisopedia/dotfiles/issues?labels=feature+request) for me to include, [log a bug](https://github.com/chrisopedia/dotfiles/issues/new), or maybe checkout the [features list](#features) to see what's included.

[![Version 2.0.0](http://img.shields.io/badge/version-2.0.0-brightgreen.svg)](https://github.com/chrisopedia/bash/releases/tag/2.0.0) [![Stories in Ready](https://badge.waffle.io/chrisopedia/dotfiles.svg?label=Ready&title=Ready)](http://waffle.io/chrisopedia/dotfiles)

## Installation

:warning: This may overwrite existing dotfiles in your `$HOME` and `.vim` directories.

### Requirements

* [curl](http://curl.haxx.se)
* [git](http://git-scm.com)
* [homebrew](http://brew.sh)
* [node](http://nodejs.org)
* [npm](https://www.npmjs.org)
* [ruby](https://www.ruby-lang.org)
* [rsync](http://rsync.samba.org)

:exclamation: N.B. [one-line installation](#one-line-install) will handle all of the dependencies for you, so it's best advised to use. Also note, [HTML Inspector](#node-packages) requires the full [xCode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12) installation, so choose accordingly when Homebrew asks you up front.

### One-line Install

```bash
$ bash -c "$(curl -#fL raw.github.com/chrisopedia/dotfiles/go/install)"
```

:exclamation: N.B. If you wish to [fork this project](https://github.com/chrisopedia/dotfiles/fork) and maintain your own dotfiles, you **MUST** substitute my username for your own in the above command and the variable (`$GITHUB_USER`) found at the top of the `bin/dotfiles` script.

## Options

| Flag              | Meaning                          |
| :-----------------| :------------------------------- |
| `-e`, `--edit`    | Edit the dotfiles                |
| `--prefix`        | Print the installation directory |
| `-t`, `--test`    | Run the test suite               |
| `-v`, `--version` | Print the current version        |

## Man page

The man page is symlinked in the install process. As long as `/usr/local/bin` is in your `$PATH`, then you should be able to access it via `man dotfiles`.

## Update

So it's time to update for [whatever reason](#when-to-update); don't fret, there is a command for that. Given everything is set up correctly, the following command should be available in your `$PATH`, meaning you can run from anywhere.

### How to update

```bash
$ dotfiles
```

### When to Update

* A change is made to `$(dotfiles --prefix)/conf/git/config` (the only file that is copied rather than symlinked).
* You want to pull changes from the remote repository
* You add a new Homebrew formulae, Ruby gems, Node packages.
* You want to update Homebrew formulae, Ruby gems, Node packages.

## Features

Besides some [custom bash prompts](#shell-custom-bash-prompt), there are several package installations handled via [Homebrew](#beer-homebrew-formulae), [Ruby gems](#gem-ruby-gems), & [npm](#node-packages) that are listed below. In addition, there are several [ViM plugins](#vim-plugins) that are installed via Vundle, and some [`<tab>` completion](#tab-completion-libraries) libraries. If you want to modify what is installed by default, removing or adding is as easy as updating the package in the appropriate file.  Each package is stored in the `opt` directory and named for the package management software that is used.

:exclamation: N.B. Each package should be on a new line.

### Homebrew formulae

* [GNU core utilities](http://www.gnu.org/software/coreutils/) - basic file, shell and text manipulation utilities of the GNU operating system; latest version
* [ack](http://betterthangrep.com/) - file search
* [bash](http://en.wikipedia.org/wiki/Bash_(Unix_shell)) - shell language; latest version
* [composer](https://getcomposer.org/) - dependency manager for PHP
* [ctags](http://ctags.sourceforge.net/) - tag generator; used for moving around function definitions
* [ffmpeg](http://ffmpeg.org/) - cross-platform solution to record, convert and stream audio and video
* [gist](http://defunkt.io/gist/) - provides a gist command that you can use from your terminal to upload content to https://gist.github.com/
* [git](http://git-scm.com/) - version control; latest version
* [git-extras](https://github.com/visionmedia/git-extras) - GIT utilities -- repo summary, repl, changelog population, author commit percentages and more
* [graphicsmagick](http://www.graphicsmagick.org/) - the swiss army knife of image processing
* [hub](http://hub.github.com/) - command-line wrapper for git that makes you better at GitHub
* [jpeg](https://en.wikipedia.org/wiki/Libjpeg) - implements JPEG decoding and encoding functions alongside various utilities for handling JPEG images
* [jq](http://stedolan.github.io/jq/) - a lightweight and flexible command-line JSON processor
* [mysql](http://www.mysql.com) - open source database
* [node](http://nodejs.org/) - platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications
* [optipng](http://optipng.sourceforge.net/) - PNG optimizer that recompresses image files to a smaller size, without losing any information
* [peco](https://github.com/peco/peco) - Simplistic interactive filtering tool
* [phantomjs](http://phantomjs.org/) - headless WebKit scriptable with a JavaScript API
* [php55 (via homebrew-php)](https://github.com/homebrew/homebrew-php) - centralized repository for PHP-related brews
* [rename](http://plasmasturm.org/code/rename/) - renames files according to modification rules specified on the command line
* [rsync](https://rsync.samba.org/) - an open source utility that provides fast incremental file transfer; latest version
* [shellcheck](http://www.shellcheck.net/) - static analysis tool for shell scripts
* [spark](https://zachholman/spark) - spark lines in your shell
* [tmux](http://tmux.sourceforge.net/) - lets you switch easily between several programs in one terminal, detach them (they keep running in the background) and reattach them to a different terminal
* [tree](http://mama.indstate.edu/users/ice/tree/) - recursive directory listing command that produces a depth indented listing of files
* [wget](http://www.gnu.org/software/wget/) - a free software package for retrieving files using HTTP, HTTPS and FTP, the most widely-used Internet protocols
* [wp-cli](http://wp-cli.org/) - set of command-line tools for managing WordPress installations
* [vim](http://www.vim.org) - the editor; latest version with python3 support

### Ruby gems

* [boom](http://zachholman.com/boom) - motherfucking text snippets on the command line
* [bundler](http://bundler.io/) - provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed
* [friction](https://github.com/rafalchmiel/friction) - a tool to get rid of common sources of contributor friction
* [jekyll](https://github.com/jekyll/jekyll) - a blog-aware, static site generator in Ruby
* [overcommit](https://github.com/causes/overcommit) - fully configurable and extendable Git hook manager
* [sass](http://sass-lang.com/) - the most mature, stable, and powerful professional grade CSS extension language in the world
* [scss-lint](https://github.com/causes/scss-lint) - configurable tool for writing clean and consistent SCSS
* [showterm](http://showterm.io/) - ideal for demoing instructions (as the user can copy-paste), making fail-safe "live-coding" sessions (plain text is very scalable), and sharing all your l33t terminal hacks.

### Node packages

* [bower](http://bower.io/) - package manager for the web
* [browser-sync](http://browsersync.io/) - time-saving synchronised browser testing
* [css-colorguard](https://github.com/SlexAxton/css-colorguard) - keep a watchful eye on your css colors
* [component(1)](http://component.io/) - client package manager
* [csscomb](http://csscomb.com/) - CSS coding style formatter
* [csslint](http://csslint.net/) - lint for CSS
* [david](https://david-dm.org/) - keep your Nodejs project dependencies up to date
* [gify](https://github.com/visionmedia/node-gify) - convert videos to gifs using ffmpeg and gifsicle
* [grunt-cli](http://gruntjs.com/) - JavaScript task runner
* [grunt-devtools](https://github.com/vladikoff/grunt-devtools) - Grunt task runner extension for Chrome Developer Tools
* [htmlhint](https://github.com/yaniswang/HTMLHint) - static code analysis tool for html
* [html-inspector](http://philipwalton.com/articles/introducing-html-inspector/) - code quality tool to help you and your team write better markup
* [imageoptim-cli](http://jamiemason.github.io/ImageOptim-CLI/) - automates batch optimisation of images
* [jshint](http://www.jshint.com/) - community-driven tool to detect errors and potential problems in JavaScript code and to enforce your team's coding conventions
* [jsonlint](http://zaach.github.io/jsonlint/) - a JSON parser and validator with a CLI
* [myth](http://myth.io/) - CSS preprocessor that acts like a polyfill for future versions of the spec
* [karma-cli](http://karma-runner.github.io/0.12/intro/installation.html) - Spectacular Test Runner for JavaScript
* [pageres](https://github.com/sindresorhus/pageres) - Responsive website screenshots
* [plato](https://github.com/es-analysis/plato) - JavaScript source code visualization, static analysis, and complexity tool
* [psi](https://github.com/addyosmani/psi/) - PageSpeed Insights for Node - with reporting
* [stylestats](http://www.stylestats.org/) - StyleStats is a Node.js library to collect CSS statistics
* [tldr](https://github.com/rprieto/tldr) - Simplified and community-driven man pages
* [uncss](https://github.com/giakki/uncss) - remove unused styles from CSS
* [vtop](https://github.com/MrRio/vtop) - graphical activity monitor for the command line
* [yo](http://yeoman.io/) - Yeoman is a robust and opinionated client-side stack, comprising tools and frameworks that can help developers quickly build beautiful web applications

### ViM plugins

* [vundle](https://github.com/gmarik/Vundle.vim) - manages all plugin installation

#### UI
* [base16-vim](https://github.com/chriskempson/base16-vim) - colorscheme
* [MatchTag](https://github.com/gregsexton/MatchTag) - highlights the matching HTML tag when the cursor is positioned on a tag
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter) - shows a git diff in the 'gutter'
* [vim-airline](https://github.com/bling/vim-airline) - statusline/tabline
* [tmuxline.vim](https://github.com/edkolev/tmuxline.vim) - tmux statusline

#### Editing

* [editorconfig-vim](https://github.com/editorconfig/editorconfig-vim) - helps developers define and maintain consistent coding styles between different editors and IDEs
* [emmet-vim](https://github.com/mattn/emmet-vim) - provides support for expanding abbreviations
* [nerdcommenter](https://github.com/scrooloose/nerdcommenter) - intensely orgasmic commenting
* [vim-surround](https://github.com/tpope/vim-surround) - quoting/parenthesizing made simple

#### Syntax

* ~~[html5.vim](https://github.com/othree/html5.vim) - HTML5 + inline SVG omnicomplete funtion, indent and syntax~~
* [syntastic](https://github.com/scrooloose/syntastic) - syntax checking plugin for ViM that runs files through external syntax checkers and displays any resulting errors to the user.
* ~~[vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax) - css(3) syntax highlight~~
* ~~[vim-git](https://github.com/tpope/vim-git) - syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail~~
* ~~[vim-haml](https://github.com/tpope/vim-haml) - Vim runtime files for Haml, Sass, and SCSS~~
* ~~[vim-javascript](https://github.com/pangloss/vim-javascript) - JavaScript bundle for ViM, this bundle provides syntax and indent plugins~~
* ~~[vim-less](https://github.com/groenewege/vim-less) - syntax highlighting, indenting and autocompletion for the dynamic stylesheet language LESS.~~
* ~~[vim-markdown](https://github.com/tpope/vim-markdown) - markdown support~~

#### Utilities

* [ctrlp.vim](https://github.com/kien/ctrlp.vim) - fuzzy file, buffer, mru, tag, etc finder
* ~~[snipmate](https://github.com/msanders/snipmate.vim) - snippet manager~~
* ~~[vim-fugitive](https://github.com/tpope/vim-fugitive) - a Git wrapper so awesome, it should be illegal~~

### &lt;tab&gt; Completion Libraries

* [Bash](http://bash-completion.alioth.debian.org/) (via Homebrew)
* [Boom](https://raw.githubusercontent.com/chrisopedia/homebrew-completions/boom-completion/boom-completion.rb) (via Homebrew)
* Git (via Homebrew)
* [Grunt](https://raw.githubusercontent.com/chrisopedia/homebrew-completions/grunt-completion/grunt-completion.rb) (via Homebrew)
* [Git Extras](https://github.com/visionmedia/git-extras/blob/master/etc/bash_completion.sh)
* [Hub](https://github.com/github/hub/blob/master/etc/hub.bash_completion.sh)
* [Vagrant](https://github.com/Homebrew/homebrew-completions/blob/master/vagrant-completion.rb) (via Homebrew)
* [WP CLI](https://raw.githubusercontent.com/chrisopedia/homebrew-completions/wpcli-completion/wpcli-completion.rb) (via Homebrew)
* Killall for common apps
* OS X NSGlobalDomain
* SSH Known Hosts

### Custom bash prompt

I use a custom bash prompt based on the [Base16 color palette](http://chriskempson.github.io/base16/) and influenced by @necolas', @gf3's and @cowboy's custom prompts.When your current working directory is a Git repository, the `$PROMPT` will display the checked-out branch's name (and failing that, the commit SHA that `HEAD` is pointing to). The state of the working tree is reflected in the following way:

| Symbol | Meaning                          |
| :----: | :------------------------------- |
| +      | Uncommitted changes              |
| !      | Unstaged changes                 |
| ?      | Untracked files                  |
| $      | Stashed files                    |

For best results, you should install [iTerm2](http://chriskempson.github.io/base16-iterm2/) and import [Base16 Eighties Dark.itermcolors](https://github.com/chriskempson/base16-iterm2/blob/master/base16-eighties.dark.256.itermcolors). Further details are in the `$(dotfiles --prefix)/conf/bash/prompt` file.

#### Screenshot

![](http://cdn.chrisopedia.me/images/dotfiles-screenshot-v2.png)

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
git commit -m "Update library with new submodule: <submodule-name>"
```

## Updating git submodules

Updating individual submodules within the superproject:

```bash
# Change to the submodule directory
cd <path/to/submodule>
# Checkout the desired branch (of the submodule)
git checkout master
# Pull from the tip of master (of the submodule - could be any sha or pointer)
git pull origin master
# Go back to main dotfiles repo root
cd $(dotfiles --prefix)
# Stage the submodule changes
git add <path/to/submodule>
# Commit the submodule changes
git commit -m "Update submodule '<submodule>' to the latest version"
# Push to a remote repository
git push origin master
```

Now, if anyone updates their local repository from the remote repository, then using `git submodule update` will update the submodules (that have been initialized) in their local repository.

:exclamation: N.B This will wipe away any local changes made to those submodules.

* * *

## Acknowledgements

Inspiration and code was taken from many sources, including (in lexicographical order):

* [@holman](https://github.com/holman) (Zach Holman) https://github.com/holman/dotfiles
* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens) https://github.com/mathiasbynens/dotfiles
* [@necolas](https://github.com/necolas) (Nicolas Gallagher) https://github.com/necolas/dotfiles
