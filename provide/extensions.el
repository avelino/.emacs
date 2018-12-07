;;; extensions.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;;; Code:

(use-package ag)

(use-package smex
  :ensure t
  :bind ("M-x" . smex))

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-x c") 'mc/edit-lines)
  (global-set-key (kbd "C-x x") 'mc/mark-all-like-this)
  (global-set-key (kbd "M-p") 'mc/mark-previous-like-this)
  (global-set-key (kbd "M-n") 'mc/mark-next-like-this))

(use-package fiplr
  ;; :disabled
  :config
  (setq fiplr-ignored-globs
	'((directories (".git" ".svn" "vendor"))
	  (files (".*" "*.jpg" "*.png" "*.zip" "*~"))))
  :bind
  ("C-x f" . fiplr-find-file))

(use-package anzu
  ;; search displays current match and total matches
  :config
  (global-anzu-mode +1)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

(use-package company
  :bind
  ("M-TAB" . company-complete)
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

(use-package docker-compose-mode)

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w"))

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
  ;; deleting whitespace character will delete all whitespace
  :config
  (global-hungry-delete-mode))

(use-package git-commit
  :init
  (global-git-commit-mode t))

(use-package gitconfig-mode
  :mode (("\\.gitconfig\\'" . gitconfig-mode)
	 ("\\.git/config\\'" . gitconfig-mode)
	 ("\\.gitmodules\\'" . gitconfig-mode)))

(use-package gitignore-mode
  :mode ("\\.gitignore\\'" . gitignore-mode))

(use-package magit
  :bind
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive)
  :config
  (setq magit-completing-read-function 'magit-builtin-completing-read
        magit-revision-show-gravatars '("^Author:     " . "^Commit:     ")
        magit-process-popup-time 3
	magit-diff-refine-hunk t)
  (with-eval-after-load 'fullframe
    (fullframe magit-status magit-mode-quit-window))
  (remove-hook 'server-switch-hook 'magit-commit-diff))

(use-package git-gutter-fringe
  :if window-system
  :config
  (use-package fringe-helper)
  (setq git-gutter-fr:side 'right-fringe)
  (add-hook 'prog-mode-hook 'git-gutter-mode)
  (add-hook 'focus-in-hook 'git-gutter:update-all-windows)
  (setq-default fringes-outside-margins t)
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted  '(center repeated)
    "XXX....."))

(use-package ido
  :ensure t
  :config
  (ido-mode 'both)
  (ido-everywhere t)
  (setq ido-auto-merge-delay-time 4
	ido-auto-merge-work-directories-length nil
	ido-default-file-method 'selected-window
	ido-enable-flex-matching t
	ido-max-window-height 1
	ido-max-prospects 10
	ido-use-virtual-buffers t
	ido-use-filename-at-point 'guess
	ido-create-new-buffer 'always
	ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el"
				    ".ini" ".cfg" ".cnf" ".conf" ".go" ".sh"
				    ".md")
	ido-ignore-extensions t
	ido-ignore-files '("\\`CVS/" "\\`#" "\\`.#" "\\`\\.\\./" "\\`\\./"
			   "\\.orig$")))

(use-package ido-grid-mode
  :ensure t
  :init
  (ido-grid-mode 1)
  :config
  (setq ido-grid-mode-max-rows 4
	ido-grid-mode-min-rows 4
        ido-max-window-height (+ ido-grid-mode-max-rows 1)))

(use-package ido-completing-read+
  :ensure t
  :config
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

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
  :ensure t
  :config
  (setq projectile-enable-caching t
	projectile-project-search-path '("~/src/")
	projectile-cache-file (expand-file-name "projectile.cache" temp-dir)
	projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" temp-dir))
  (add-hook 'prog-mode-hook 'projectile-mode)
  (add-hook 'projectile-after-switch-project-hook #'go-set-project)
  (add-hook 'after-init-hook #'projectile-global-mode)
  (projectile-global-mode)
  :bind
  ("C-x p a" . projectile-ag)
  ("C-x p p" . projectile-switch-project))

(use-package yasnippet
  :bind
  ("C-c y s" . yas-insert-snippet)
  ("C-c y v" . yas-visit-snippet-file)
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets)

(use-package zoom-window
  :bind
  ("C-x C-z" . zoom-window-zoom)
  :config
  (setq zoom-window-mode-line-color "#22252c"))

(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(use-package toml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.toml\\'" . toml-mode)))

(use-package server
  :init
  (add-hook 'after-init-hook #'server-start t))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t
	auto-package-update-interval 4)
  (auto-package-update-maybe))

(provide 'extensions)

;;; extensions.el ends here
