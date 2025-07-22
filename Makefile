REPO := dotfiles
INSTALL_SCRIPT := bin/install
LOG_FILE := $(XDG_STATE_HOME)/$(REPO)/install.log
TARBALL := $(REPO).tar.gz
TEST_SCRIPT := test/assertions.sh
DIST_DIR := dist
ARCHIVE_NAME := $(REPO).tar.gz
GITHUB_REPO := $(shell git config --get remote.origin.url | sed -E 's/.*github.com[/:](.*).git/\1/')

DIST_EXCLUDES := \
  --exclude=.git \
  --exclude=node_modules \
  --exclude=dist \
  --exclude=test \
  --exclude=.DS_Store \
  --exclude=*.log \
  --exclude=*.tar.gz

.PHONY: all install test clean package logs docker dist test-dist release \
        bump-patch bump-minor bump-major changelog print-version

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

print-version:
	@echo "🔖 Latest version: $$(git describe --tags --abbrev=0)"

define bump_template
latest=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
clean=$${latest#v}; \
IFS=. read -r major minor patch <<< "$$clean"; \
new="$$( \
  case "$(1)" in \
    patch) echo "$$major.$$minor.$$((patch + 1))" ;; \
    minor) echo "$$major.$$((minor + 1)).0" ;; \
    major) echo "$$((major + 1)).0.0" ;; \
  esac \
)"; \
echo "🚀 Bumping $(1): $$latest → v$$new"; \
if git rev-parse "v$$new" >/dev/null 2>&1; then \
  echo "⚠️  Tag v$$new already exists. Skipping."; \
  exit 1; \
fi; \
if [ "$(DRY_RUN)" = "1" ]; then \
  echo "🔍 DRY RUN: would tag v$$new and push"; \
else \
  git tag -s "v$$new" -m "Release v$$new"; \
  git push origin "v$$new"; \
  make release VERSION="v$$new" AUTO_NOTES=1; \
fi
endef

bump-patch:
	@$(call bump_template,patch)

bump-minor:
	@$(call bump_template,minor)

bump-major:
	@$(call bump_template,major)

release: dist changelog
	@CHANGES=$$(git log --oneline $$(git describe --tags --abbrev=0 HEAD^)..HEAD --no-merges); \
	if [ -z "$$CHANGES" ]; then \
	  echo "⚠️  No new commits since last release. Skipping."; \
	  exit 0; \
	fi; \
	VERSION_CLEAN=$(shell echo $(VERSION) | sed 's/^v//'); \
	echo "🚀 Releasing version: v$$VERSION_CLEAN"; \
	echo "🔐 Committing updated CHANGELOG.md..."; \
	git add CHANGELOG.md; \
	if git diff --cached --quiet; then \
	  echo "ℹ️ No changes to commit in CHANGELOG.md."; \
	else \
	  git commit -S -m "docs: update CHANGELOG for v$$VERSION_CLEAN"; \
	  git push origin HEAD; \
	fi; \
	if [ "$(AUTO_NOTES)" = "1" ]; then \
		LAST_TAG=$$(git describe --tags --abbrev=0 HEAD^); \
		NOTES_FILE=".release-notes.md"; \
		echo "# ✨ What's New in v$$VERSION_CLEAN" > $$NOTES_FILE; \
		echo >> $$NOTES_FILE; \
		echo "## 🚀 Features" >> $$NOTES_FILE; \
		git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep '^.*|feat:' | \
		  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,7), $$1, $$1, $$3 }' >> $$NOTES_FILE; \
		echo >> $$NOTES_FILE; \
		echo "## 🐛 Fixes" >> $$NOTES_FILE; \
		git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep '^.*|fix:' | \
		  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,6), $$1, $$1, $$3 }' >> $$NOTES_FILE; \
		echo >> $$NOTES_FILE; \
		echo "## 🧹 Maintenance" >> $$NOTES_FILE; \
		git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep -E '^.*\|(chore|refactor):' | \
		  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,index($$2,":")+2), $$1, $$1, $$3 }' >> $$NOTES_FILE; \
	else \
		NOTES_FILE=""; \
	fi; \
	gh release create "v$$VERSION_CLEAN" \
		--title "v$$VERSION_CLEAN" \
		--notes-file "$$NOTES_FILE" \
		"$(DIST_DIR)/$(ARCHIVE_NAME)"; \
	rm -f .release-notes.md

changelog:
	@echo "📝 Updating CHANGELOG.md..."
	@VERSION_CLEAN=$(shell echo $(VERSION) | sed 's/^v//'); \
	LAST_TAG=$$(git describe --tags --abbrev=0 HEAD^); \
	DATE=$$(date +%Y-%m-%d); \
	echo "## v$$VERSION_CLEAN - $$DATE" > .changelog.tmp; \
	echo >> .changelog.tmp; \
	echo "### 🚀 Features" >> .changelog.tmp; \
	git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep '^.*|feat:' | \
	  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,7), $$1, $$1, $$3 }' >> .changelog.tmp; \
	echo >> .changelog.tmp; \
	echo "### 🐛 Fixes" >> .changelog.tmp; \
	git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep '^.*|fix:' | \
	  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,6), $$1, $$1, $$3 }' >> .changelog.tmp; \
	echo >> .changelog.tmp; \
	echo "### 🧹 Maintenance" >> .changelog.tmp; \
	git log $$LAST_TAG..HEAD --pretty=format:"%h|%s|%an" --no-merges | grep -E '^.*\|(chore|refactor):' | \
	  awk -F '|' '{ printf "- %s ([`%s`](https://github.com/$(GITHUB_REPO)/commit/%s)) (%s)\n", substr($$2,index($$2,":")+2), $$1, $$1, $$3 }' >> .changelog.tmp; \
	echo >> .changelog.tmp; \
	touch CHANGELOG.md; \
	cat .changelog.tmp CHANGELOG.md > .changelog.new; \
	mv .changelog.new CHANGELOG.md; \
	rm .changelog.tmp; \
	echo "✅ CHANGELOG.md updated"
