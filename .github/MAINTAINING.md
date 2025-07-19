# How to Maintain

Check out The Holocron Archive's [Guide to Maintaining](https://docs.theholocron.dev/maintaining/) for more information.  The following is a specific set of instructions that are designed to help the maintainers.

## 🎛 Tooling

The included `Makefile` provides simple commands for development, testing, and packaging:

| Target        | Description                                          |
|---------------|------------------------------------------------------|
| `make install`| Run the main install script (`bin/install`)          |
| `make test`   | Run the local assertions in `test/assertions.sh`     |
| `make docker` | Run the install script inside a Docker container     |
| `make logs`   | View install log file via `less`                     |
| `make package`| Create a compressed tarball of the dotfiles          |
| `make clean`  | Remove generated tarball and log files               |
| `make dist`  | Create a release tarball in `dist/` |
| `make test-dist`  | Confirm the archive contains required files |
| `make release`  | Trigger a GitHub Release with version set via `VERSION=` |

## 🤝 Contributing

To test your changes before submitting a PR:

```shell
make docker
make test
```

### 📁 Output Logs

All logs are written to:

```shell
$HOME/.local/state/dotfiles/install.log
```

Use `make logs` to inspect them.

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

```shell
DOTFILES_NONINTERACTIVE=1 DEBUG=true make install
```

## 🐳 Build the Container

To test the installation in a sandbox using Docker:

```bash
make docker
```

This builds a container, runs the installer inside it, and prints results. Useful for local testing before pushing.

## 📦 GitHub Releases

To publish a new release:

###	Create and push a Git tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

###	GitHub Actions will:

* Package the dotfiles
* Create a release draft
* Upload the archive to the release

Alternatively, release manually using:

```bash
make release VERSION=1.0.0
```

:notebook_with_decorative_cover: Requires the GitHub CLI (gh) and a valid token.
