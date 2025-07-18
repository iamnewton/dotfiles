# 🛠 dotfiles(1)

A highly-configurable, cross-platform [`dotfiles`](https://dotfiles.github.io/) setup built with:

- ✅ Idempotent, modular shell scripts
- 🐳 Docker test harness
- 🧪 Bash-based assertions
- 📦 Easy packaging
- ⚙️ GitHub Actions CI ready

**N.B.** This project has a [Code of Conduct](./.github/CODE_OF_CONDUCT.md). By interacting with this repository, organization, and/or community you agree to abide by its terms.

## 🚀 Installation

Typically software you buy comes with some sort of installer, why not your dotfiles? Here's a one-liner to get you up and running.

```bash
$ /bin/bash -c "$(curl -#fL https://raw.githubusercontent.com/iamnewton/dotfiles/main/bin/install)"
```

### Manual Installation

If you prefer to download, inspect and run, you can use the following process.

Ensure that you have the following dependencies installed on your system.  If you're on MacOS then you already have these, but a Linux system may not come with all.

- [curl](https://curl.se/) – Command-line tool for transferring data with URLs (supports HTTP, FTP, and many more)
- [git](https://git-scm.com/) – Distributed version control system
- [sudo](https://man7.org/linux/man-pages/man8/sudo.8.html) – Execute commands as another user (commonly root)
- [bash](https://www.gnu.org/software/bash/) – GNU Bourne Again SHell
- [ca-certificates](https://packages.debian.org/search?keywords=ca-certificates) – Common CA certificates (Debian/Ubuntu package)
- [software-properties-common](https://manpages.ubuntu.com/manpages/questing/en/man1/add-apt-repository.1.html) – Manage apt repositories (Ubuntu)
- [build-essential](https://packages.ubuntu.com/search?keywords=build-essential) – Package with compiler and build tools for Debian/Ubuntu
- [unzip](https://linux.die.net/man/1/unzip) – Extract .zip archives

```bash
git clone https://github.com/iamnewton/dotfiles $HOME/.local/lib/dotfiles
cd $HOME/.local/lib/dotfiles
make install;
```

:exclamation: N.B. If you wish to [fork this project](https://github.com/iamnewton/dotfiles/fork) and maintain your own dotfiles, you **MUST** substitute my username for your own in the above command and the variable (`$USERNAME`) found at the top of the `bin/install.sh` script.

## 🔐 Environment Variables

The script supports the following environment variables:

| Variable                | Description                              |
|-------------------------|------------------------------------------|
| `DOTFILES_NONINTERACTIVE` | Set to `1` to skip all prompts         |
| `GIT_AUTHOR_NAME`       | Default Git author name                  |
| `GIT_AUTHOR_EMAIL`      | Default Git author email                 |
| `DOTFILES_MACOS_APPS`   | `y` or `n` to enable/disable macOS apps  |
| `GNUPGHOME`             | Override GPG key directory               |
| `DEBUG`                 | Set to `true` for verbose output         |

You can pass them inline:

```bash
DOTFILES_NONINTERACTIVE=1 DEBUG=true make install
```

## 🐳 Run in Docker

To test the installation in a sandbox:

```bash
make docker
```

This builds a container, runs the installer inside it, and prints results. Useful for local testing before pushing.

### 📁 Output Logs

All logs are written to:

```bash
$HOME/.local/state/dotfiles/install.log
```

Use `make logs` to inspect them.

## 🧪 Testing

To test your changes before submitting a PR:

```bash
make docker
make test
```

* * *

## Acknowledgements

Inspiration and code was taken from many sources, including (in lexicographical order):

* [@holman](https://github.com/holman) (Zach Holman) https://github.com/holman/dotfiles
* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens) https://github.com/mathiasbynens/dotfiles
* [@necolas](https://github.com/necolas) (Nicolas Gallagher) https://github.com/necolas/dotfiles
