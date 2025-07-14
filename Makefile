REPO := dotfiles
VERSION ?= $(shell date +%Y.%m.%d)
INSTALL_SCRIPT := bin/install
LOG_FILE := $(XDG_STATE_HOME)/$(REPO)/install.log
TARBALL := $(REPO).tar.gz
TEST_SCRIPT := test/assertions.sh
DIST_DIR := dist
ARCHIVE_NAME := $(REPO).tar.gz

DIST_EXCLUDES := \
  --exclude=.git \
  --exclude=node_modules \
  --exclude=dist \
  --exclude=test \
  --exclude=.DS_Store \
  --exclude=*.log \
  --exclude=*.tar.gz

.PHONY: all install test clean package logs docker dist test-dist release

all: install

install:
	@echo "▶️  Running dotfiles install script..."
	@chmod +x $(INSTALL_SCRIPT)
	@DOTFILES_NONINTERACTIVE=1 ./$(INSTALL_SCRIPT)

test:
	@echo "🧪 Running test assertions..."
	@chmod +x $(TEST_SCRIPT)
	@bash $(TEST_SCRIPT)

package:
	@echo "📦 Creating tarball: $(TARBALL)"
	@tar --exclude-vcs -czf $(TARBALL) .

clean:
	@echo "🧹 Cleaning up..."
	@rm -f $(TARBALL)
	@rm -f $(LOG_FILE)

logs:
	@echo "📜 Showing install log..."
	@cat $(LOG_FILE)

docker:
	@echo "🐳 Running Docker-based test..."
	@bash test/run.sh

dist: clean
	@echo "📦 Packaging dotfiles..."
	@mkdir -p $(DIST_DIR)
	tar czf $(DIST_DIR)/$(ARCHIVE_NAME) $(DIST_EXCLUDES) .
	@echo "✅ Package created: $(DIST_DIR)/$(ARCHIVE_NAME)"

test-dist: dist
	@echo "🔍 Testing archive contents..."
	@tar -tf $(DIST_DIR)/$(ARCHIVE_NAME) | grep install || echo "❌ 'install' not found in archive"

release: dist
	@echo "🚀 Releasing new version: v$(VERSION)"
	@gh release create "v$(VERSION)" \
		--title "v$(VERSION)" \
		--notes "Automated release of v$(VERSION)" \
		"$(DIST_DIR)/$(ARCHIVE_NAME)"
