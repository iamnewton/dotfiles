#!/usr/bin/env bash
set -euo pipefail

# Set default permissions for new files and directories to 755/644
# Ensures created files are owner-writable, but not group/world-writable (e.g., ~/.ssh, ~/.config)
# Helps avoid accidentally creating insecure or overly permissive files
umask 022

readonly DEBUG="${DEBUG:-false}" # set DEBUG=true to see full output
readonly DOCKERFILE="test/Dockerfile"
readonly IMAGE_NAME="dotfiles-test"
readonly CONTAINER_NAME="dotfiles-test"

# ANSI color codes
CYAN="\033[1;36m"
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
DIM_WHITE="\033[2;37m"
RESET="\033[0m"
LOG_PREFIX="${CYAN}[docker]${RESET}"

# Logging
error() { echo -e "${LOG_PREFIX}: ❌ ${RED}$1${RESET}" >&2; }
log() { echo -e "${LOG_PREFIX}: ${DIM_WHITE}$1${RESET}"; }
info() { echo -e "${LOG_PREFIX}: ℹ️ ${BLUE}$1${RESET}"; }
success() { echo -e "${LOG_PREFIX}: ✅ ${GREEN}$1${RESET}"; }
warn() { echo -e "${LOG_PREFIX}: ⚠️ ${YELLOW}$1${RESET}"; }

log "🛠 Building $IMAGE_NAME from $DOCKERFILE"
if [[ "$DEBUG" == "true" ]]; then
	docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .
else
	docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" . &>/dev/null
fi

log "⚓Running install script inside container..."
# docker run --rm -it --name "$CONTAINER_NAME" "$IMAGE_NAME" -c "cd dotfiles && ./bin/install" -e DOTFILES_NONINTERACTIVE=1
# debug version
# docker run -it --name "$CONTAINER_NAME" -e DOTFILES_NONINTERACTIVE=1 "$IMAGE_NAME" /bin/bash -c "cd dotfiles && ./bin/install || exec bash"
# mounted version
docker run -it --name "$CONTAINER_NAME" -e DOTFILES_NONINTERACTIVE=1 -v "$PWD":/home/tester/dotfiles "$IMAGE_NAME"
