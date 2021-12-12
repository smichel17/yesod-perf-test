STACK_DIR::=.stack-work-devel

YESOD_FLAGS::=--flag yesod-perf-test:dev #--flag yesod-perf-test:library-only
GHCI_OPTS::=-fobject-code -O0 -isrc

ghcid: ## Run the server in fast development mode
	stack exec -- ghcid \
		--command="stack ghci --work-dir $(STACK_DIR) --only-main app/main.hs $(YESOD_FLAGS) --ghci-options='$(GHCI_OPTS)'" \
		--run="Main.main"

watch-templates:
	find ./ -type f \( -iname \*.hamlet \) | entr -s '\
		A="$$(basename $$0)"; B="$${A^}"; C="src/Handler/$${B:0:-6}hs";\
		if test -f "$$C"; then touch "$$C"; else touch src/Foundation.hs; fi\
	'

ghci:
	stack ghci --work-dir $(STACK_DIR) --only-main app/main.hs --ghci-options='$(GHCI_OPTS)'

install:
	stack build --install-ghc yesod-bin ghcid

build:
	stack build --work-dir $(STACK_DIR)

.PHONY: ghcid ghci watch-templates
