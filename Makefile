# Ensure emacs always runs from this makefile's PWD
EMACS_FLAGS=--eval '(setq user-emacs-directory default-directory)' -l init.el
EMACS=emacs --quick --batch $(EMACS_FLAGS)
EMACSI=emacs -q $(EMACS_FLAGS)

.PHONY: all install run

all: install

## Package management
install:
	@$(EMACS)

run:
	@$(EMACSI)