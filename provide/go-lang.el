;;; go-lang.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;; REQUIREMENTS:
;; go get -u golang.org/x/tools/cmd/...
;; go get -u github.com/rogpeppe/godef
;; go get -u github.com/nsf/gocode
;; go get -u github.com/kisielk/errcheck
;;
;;; Code:

;; Snag the user's PATH and GOPATH
;; (setenv "GOPATH" "/Users/avelino")

(use-package go-mode
  :config
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  (add-hook 'go-mode-hook 'company-mode)
  ;; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook 'setup-go-mode-compile)
  (add-hook 'go-mode-hook #'smartparens-mode)
  (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
  (add-hook 'go-mode-hook (lambda ()
			     (setq tab-width 4)
			     (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
  			     (local-set-key (kbd "C-c C-g") 'go-goto-imports)
			     (set (make-local-variable 'company-backends) '(company-go))
			     (company-mode)))

  :init
  (use-package go-guru
    :init
    (go-guru-hl-identifier-mode))


  (use-package go-errcheck)

  (use-package go-add-tags)

  (use-package company-go
    :after go-mode
    :bind (:map go-mode-map
					; Godef jump key binding
		("M-." . godef-jump)))

  (use-package flymake-go)

  (use-package flycheck-gometalinter
    :ensure t
    :config
    (progn
      (flycheck-gometalinter-setup))
    (setq
     ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
     flycheck-gometalinter-vendor         t
     ;; only show errors
     flycheck-gometalinter-errors-only    t
     ;; only run fast linters
     flycheck-gometalinter-fast           t
     ;; use in tests files
     flycheck-gometalinter-test           t
     ;; Only enable selected linters
     flycheck-gometalinter-enable-linters '("golint" "gotype" "gocyclo")
     ;; Set different deadline (default: 5s)
     flycheck-gometalinter-deadline       "10s"))

  (use-package go-eldoc
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup))

  (use-package go-autocomplete))

(defun setup-go-mode-compile ()
  "Customize compile command to run go build"
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet")))

(provide 'go-lang)

;;; go-lang.el ends here
