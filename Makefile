STACK_DIR::=.stack-work-devel
YESOD_FLAGS::=--flag yesod-perf-test:dev #--flag yesod-perf-test:library-only
GHCI_OPTS::=-fobject-code -O0 -isrc
GHCI_DUMP::=-ddump-timings -ddump-to-file

$(TIME_GHC_MODULES_BIN)::=./time-ghc-modules/time-ghc-modules

setup: $(TIME_GHC_MODULES_BIN) install build

$(TIME_GHC_MODULES_BIN):
	git submodule init
	git submodule update

install:
	stack build --install-ghc yesod-bin ghcid

build:
	stack build --work-dir $(STACK_DIR) # might need to include ghc options here

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
	stack ghci --work-dir $(STACK_DIR) --only-main app/main.hs --ghci-options='$(GHCI_OPTS) $(GHCI_DUMP)'

analyze: $(TIME_GHC_MODULES_BIN)
	xdg-open "$$($(TIME_GHC_MODULES_BIN))"

clean-dumps:
	find . -name "*.dump-timings" -exec rm '{}' \;

.PHONY: setup install build ghcid ghci watch-templates analyze clean-dumps

##
# Options from earlier experiments to rule out as not needed
##

# OBJECT_DIR::=$(STACK_DIR)/.ghci-build-artifacts
# GHCI_OPTS=-fobject-code -outputdir $(OBJECT_DIR) -fno-break-on-exception -fno-break-on-error -v1 -ferror-spans -j
		# --run="DevelMain.update"
		# --reload="src/**"
		# -ddump-splices -ddump-timings
		# --reload="templates/**"
		# --target=yesod-perf-test:lib \
		# --test "DevelMain.update"
		# --command="stack ghci --work-dir .stack-work-devel --only-main app/DevelMain.hs --ghci-options='-fobject-code -isrc'" \
