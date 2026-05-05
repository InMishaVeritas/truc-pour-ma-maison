.PHONY: help diff apply test backup edit debug install-deps

CONF := config.jsonnet
BACKUP_DIR := backups
TIMESTAMP := $(shell date +%Y%m%d-%H%M%S)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

diff: ## Show what would change in Gmail (dry-run)
	gmailctl diff -f $(CONF)

apply: ## Apply local config to Gmail (after confirmation)
	gmailctl apply -f $(CONF) -r

test: ## Run filter tests
	gmailctl test -f $(CONF)

debug: ## Show annotated/expanded version of the config
	gmailctl debug -f $(CONF)

edit: ## Edit and apply (gmailctl's interactive mode)
	gmailctl edit -f $(CONF)

backup: ## Download current Gmail filters to a timestamped backup file
	@mkdir -p $(BACKUP_DIR)
	gmailctl download > $(BACKUP_DIR)/gmail-$(TIMESTAMP).jsonnet
	@echo "Backed up to $(BACKUP_DIR)/gmail-$(TIMESTAMP).jsonnet"

install-deps: ## Install gmailctl (macOS via Homebrew)
	brew install gmailctl

clean-backups: ## Remove backup files older than 90 days
	find $(BACKUP_DIR) -name 'gmail-*.jsonnet' -mtime +90 -delete
