#!/usr/bin/env bash
set -euo pipefail

# Set default permissions for new files and directories to 755/644
# Ensures created files are owner-writable, but not group/world-writable (e.g., ~/.ssh, ~/.config)
# Helps avoid accidentally creating insecure or overly permissive files
umask 022

readonly DOCKER_IMAGE="dotfiles-test"
readonly DOCKERFILE="test/Dockerfile"

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

log "🛠 Building $DOCKER_IMAGE from $DOCKERFILE"
docker build -f "$DOCKERFILE" -t "$DOCKER_IMAGE" .

log "⚓Running install script inside container..."
docker run --rm -it \
	--name dotfiles-test \
	"$DOCKER_IMAGE" \
	-c "cd dotfiles && ./bin/install"
