STACK_DIR::=.stack-work-devel

YESOD_FLAGS::=--flag yesod-perf-test:dev --flag yesod-perf-test:library-only
GHCI_OPTS::=-fobject-code -O0 -isrc

ghcid: ## Run the server in fast development mode
	stack exec -- ghcid \
		--command="stack ghci --work-dir $(STACK_DIR) --only-main app/main.hs $(YESOD_FLAGS) --ghci-options='$(GHCI_OPTS)'" \
		--run="Main.main"

ghci:
	stack ghci --work-dir $(STACK_DIR) --only-main app/main.hs --ghci-options='$(GHCI_OPTS)'

.PHONY: ghcid ghci
