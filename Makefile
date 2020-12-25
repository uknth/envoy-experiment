SHELL := /bin/bash
proj_name := $(shell basename "$(PWD)")

# common go build makefile
bin_go := $(shell command -v go 2> /dev/null)
ifndef bin_go 
$(error Missing `go` binary from $PATH)
endif

# support binary, not needed for every case
skaffold_bin := $(shell command -v skaffold 2> /dev/null)
docker_bin := $(shell command -v docker 2> /dev/null)

default: skaffold

_print:
	@echo "--------------------------------------------"
	@echo "              $(proj_name) MAKE FILE              "
	@echo "--------------------------------------------"
	
_skaffold_check:
ifndef skaffold_bin
	$(error "missing skaffold bin, can't deploy")
endif
	@echo " > Found: [skaffold] binary"

skaffold:
	@-$(MAKE) --no-print-directory  _print _skaffold_check
	@echo " > Run: skaffold dev --skip-tests=true --status-check=false"
	@skaffold dev --skip-tests=true --status-check=false


.PHONY: _skaffold_check skaffold