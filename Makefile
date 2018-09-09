# Ensure emacs always runs from this makefile's PWD
EMACS_FLAGS=--eval '(setq user-emacs-directory default-directory)' -l init.el
EMACS=emacs --quick --batch $(EMACS_FLAGS)
EMACSI=emacs -q $(EMACS_FLAGS)

.PHONY: all install run

all: install

## install all golang packages
gopkgs:
	@go get -u github.com/zmb3/gogetdoc
	@go get -u golang.org/x/tools/cmd/guru
	@go get -u github.com/golang/lint/golint
	@go get -u github.com/davidrjenni/reftools/cmd/fillstruct
	@go get -u github.com/rogpeppe/godef
	@go get -u github.com/fatih/motion
	@go get -u github.com/kisielk/errcheck
	@go get -u github.com/derekparker/delve/cmd/dlv
	@go get -u github.com/mdempsky/gocode
	@go get -u github.com/jstemmer/gotags
	@go get -u github.com/jstemmer/gotags
	@go get -u github.com/josharian/impl
	@go get -u golang.org/x/tools/cmd/goimports
	@go get -u github.com/koron/iferr
	@go get -u github.com/fatih/gomodifytags
	@go get -u honnef.co/go/tools/cmd/keyify
	@go get -u golang.org/x/tools/cmd/gorename
	@go get -u github.com/klauspost/asmfmt/cmd/asmfmt
	@go get -u github.com/alecthomas/gometalinter

## Package management
install: gopkgs
	@$(EMACS)

run:
	@$(EMACSI)
