;;; extensions.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;;; Code:

(eval-after-load 'grep
  '(progn
    (add-to-list 'grep-find-ignored-directories "local")
    (add-to-list 'grep-find-ignored-directories "build")
    (add-to-list 'grep-find-ignored-directories "media")))
(add-hook 'grep-mode-hook (lambda() (toggle-truncate-lines 1)))

(use-package ag)

(use-package fiplr
  ;; :disabled
  :config
  (setq fiplr-ignored-globs
	'((directories (".git" ".svn" "vendor"))
	  (files (".*" "*.jpg" "*.png" "*.zip" "*~"))))
  :bind
  ("C-x f" . fiplr-find-file))

(use-package anzu
  :config
  (global-anzu-mode +1)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

(use-package company
  :bind
  ("M-TAB" . company-complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dockerfile-mode)

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

(use-package exec-path-from-shell
  :config
  ;; Add GOPATH to shell
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "PYTHONPATH")
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

(use-package flycheck
  :config
  (setq flycheck-indication-mode 'right-fringe
      ;; Removed checks on idle/change for snappiness
      flycheck-check-syntax-automatically '(save mode-enabled)
      flycheck-highlighting-mode 'symbols
      flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc make)
      ;; `flycheck-pos-tip'
      flycheck-pos-tip-timeout 10
      flycheck-display-errors-delay 0.5)
  (when (eq window-system 'mac)
    (require 'flycheck-pos-tip)
    (flycheck-pos-tip-mode +1))
  ;; Enable flycheck
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package hl-line
  :config
  ;; Doesn't seem to play nice in emacs 25+
  (setq hl-line-sticky-flag nil
        global-hl-line-sticky-flag nil)

  (defvar-local current-hl-line-mode nil)
  (defun hl-line-on ()  (if current-hl-line-mode (hl-line-mode +1)))
  (defun hl-line-off () (if current-hl-line-mode (hl-line-mode -1)))
  ;;(add-hook hl-line-mode (lambda () (if current-hl-line-mode (setq current-hl-line-mode t))))
  (global-hl-line-mode))

(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

(use-package imenu-list
  :config
  (setq imenu-list-focus-after-activation t
	imenu-list-size 0.2
	imenu-list-auto-resize nil)
  :bind
  ("C-c m l" . imenu-list-minor-mode))

(use-package git-commit)

(use-package gitconfig-mode)

(use-package gitignore-mode)

(use-package magit
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive)
  :config
  (remove-hook 'server-switch-hook 'magit-commit-diff))

(use-package ido
  :config
  (ido-mode 'both)
  (ido-everywhere t)
  (setq ido-auto-merge-delay-time 4
	ido-enable-flex-matching t
	ido-max-window-height 1
	ido-use-virtual-buffers t
	ido-use-filename-at-point 'guess
	ido-create-new-buffer 'always
	ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el"
				    ".ini" ".cfg" ".cnf" ".conf" ".go" ".sh")
	ido-ignore-extensions t
	ido-ignore-files '("\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./"
			   "\\.orig$")))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer))

(use-package ido-grid-mode
  :ensure t
  :init
  (ido-grid-mode 1)
  :config
  (setq ido-grid-mode-max-rows 4
	ido-grid-mode-min-rows 4)
  (setq ido-max-window-height (+ ido-grid-mode-max-rows 1)))

(use-package flx-ido
  :ensure t
  :config
  (flx-ido-mode t)
  (setq ido-enable-flex-matching t))

(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package page-break-lines)

(use-package projectile
  :config
  (setq projectile-enable-caching t
	projectile-cache-file (expand-file-name "projectile.cache" temp-dir)
	projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" temp-dir))
  ;; (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  :bind
  ("C-x c a" . projectile-ag))

(use-package smex
  :disabled
  :ensure t
  :config
  (setq smex-save-file (expand-file-name "smex-items" temp-dir))
  :bind
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands)
  ;; if you want to be able to M-x without meta
  ("C-x C-m" . smex)
  ;; default Emacs M-x
  ("C-c C-c M-x" . execute-extended-command)
  :init
  (smex-initialize))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  ;; Remember undo history
  (setq undo-tree-auto-save-history        nil
	undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/")))))

(use-package yasnippet
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file)
  :config
  (yas-global-mode 1))

(use-package zoom-window
  :bind
  ("C-x C-z" . zoom-window-zoom)
  :config
  (setq zoom-window-mode-line-color "#22252c"))

(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(use-package server
  :init
  (add-hook 'after-init-hook #'server-start t))

(use-package yasnippet-snippets)

(provide 'extensions)

;;; extensions.el ends here