(eval-after-load 'grep
  '(progn
    (add-to-list 'grep-find-ignored-directories "local")
    (add-to-list 'grep-find-ignored-directories "build")
    (add-to-list 'grep-find-ignored-directories "media")))
(add-hook 'grep-mode-hook (lambda() (toggle-truncate-lines 1)))

(use-package ace-jump-mode
  :bind
  ("C-c SPC" . ace-jump-mode))

(use-package ag)

(use-package fiplr
  :config
  (setq fiplr-ignored-globs '((directories (".git" ".svn" "vendor"))
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
  (exec-path-from-shell-initialize))

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

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

(use-package ivy
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package ido
  :config
  (ido-mode 'both)
  (ido-everywhere t)
  (setq ido-auto-merge-delay-time 4
	ido-enable-flex-matching t
	ido-max-window-height 1
	ido-use-virtual-buffers t
	;; ido-use-filename-at-point 'guess
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

(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :config
  (setq magit-completing-read-function 'ivy-completing-read)
  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

(use-package markdown-mode)

(use-package multiple-cursors
  :config
  (setq mc/list-file (concat temp-dir "/.mc-lists.el"))
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this)
  ("C-c ;" . mc/skip-to-next-like-this))

(use-package neotree
  :config
  (setq neo-theme 'arrow
        neotree-smart-optn t
        neo-window-fixed-size nil)
  (neotree-projectile-action)
  ;; Disable linum for neotree
  (add-hook 'neo-after-create-hook 'disable-neotree-hook)
  :bind
  ("C-x C-t" . neotree-toggle))

(use-package org
  :config
  (setq org-directory "~/DropBox/org-mode"
        org-agenda-files (list (concat org-directory "/ideas.org"))
        org-default-notes-file (concat org-directory "/todo.org"))
  (org-babel-do-load-languages
   'org-babel-load-languages '((python . t)))
  :bind
  ("\C-cl" . org-store-link)
  ("\C-ca" . org-agenda))

(use-package org-projectile
  :config
  (org-projectile:per-repo)
  (setq org-projectile:per-repo-filename "todo.org"
	org-agenda-files (append org-agenda-files (org-projectile:todo-files)))
  :bind
  ("C-c c" . org-projectile:capture-for-current-project)
  ("C-c n p" . org-projectile:project-todo-completing-read))

(use-package org-bullets
  :config
  (setq org-hide-leading-stars t)
  (add-hook 'org-mode-hook
            (lambda ()
              (org-bullets-mode t))))

(use-package page-break-lines)

;; (use-package persp-mode
;;   :init
;;   (persp-mode)
;;   (setq persp-save-dir (concat private-dir "/persp-confs/")
;; 	persp-auto-save-opt 0)
;;   :config
;;   (add-hook 'kill-emacs-hook 'persp/close-perspective)
;;   :bind
;;   ("C-x p p" . persp/switch-to-current-branch-persp))

(use-package projectile
  :config
  (setq projectile-enable-caching t
	projectile-cache-file (expand-file-name "projectile.cache" temp-dir)
	projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" temp-dir))
  (setq projectile-completion-system 'ivy)
  (projectile-global-mode)
  :bind
  ("C-x c a" . projectile-ag))

(use-package dashboard
  :config
  (setq dashboard-items '((agenda . 5)
			  (recents  . 5)
			  (projects . 5)
			  (bookmarks . 5)))
  (dashboard-setup-startup-hook))

(if (memq window-system '(mac ns))
    (use-package dash-at-point
      :bind
      ("C-c d" . dash-at-point)
      ("C-c e" . dash-at-point-with-docset))
  (use-package zeal-at-point
    :bind
    ("C-c d" . zeal-at-point)))

(use-package recentf
  :config
  (setq recentf-exclude '("/elpa/" ;; ignore all files in elpa directory
                          ".*?autoloads.el$"
                          "/tmp/" ;; ignore temporary files
			  )
	recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package restclient
  :init
  (setq restclient-log-request t
	restclient-same-buffer-response t))

(use-package rotate
  :bind
  ("C-c C-r w" . rotate-window)
  ("C-c C-r l" . rotate-layout))

(use-package smartparens)

(use-package smex
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

(use-package syntax-subword
  :config
  (syntax-subword-mode)
  :bind
  ("M-j" . syntax-subword-backward)
  ("M-l" . syntax-subword-forward))

(use-package undo-tree
  :config
  (global-undo-tree-mode 1)
  ;; Remember undo history
  (setq undo-tree-auto-save-history        nil
	undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/")))))

(use-package which-key
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("C-c i" . windmove-up)
  ("C-c k" . windmove-down)
  ("C-c j" . windmove-left)
  ("C-c l" . windmove-right))

(use-package wgrep)

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

(use-package diminish
  :config
  (defmacro diminish-minor-mode (filename mode &optional abbrev)
    `(eval-after-load (symbol-name ,filename)
       '(diminish ,mode ,abbrev)))

  (defmacro diminish-major-mode (mode-hook abbrev)
    `(add-hook ,mode-hook
	       (lambda () (setq mode-name ,abbrev))))

  (diminish-minor-mode 'abbrev 'abbrev-mode)
  (diminish-minor-mode 'company 'company-mode)
  (diminish-minor-mode 'elpy 'elpy-mode)
  (diminish-minor-mode 'eldoc 'eldoc-mode)
  (diminish-minor-mode 'flycheck 'flycheck-mode)
  (diminish-minor-mode 'flyspell 'flyspell-mode)
  (diminish-minor-mode 'projectile 'projectile-mode)
  (diminish-minor-mode 'undo-tree 'undo-tree-mode)
  (diminish-minor-mode 'yasnippet 'yas-minor-mode)
  (diminish-minor-mode 'magit 'auto-revert-mode)
  (diminish-minor-mode 'Git-Gutter 'git-gutter-mode)
  (diminish-minor-mode 'Which-Key 'which-key-mode)
  (diminish-minor-mode 'ivy 'ivy-mode)
  (diminish-major-mode 'emacs-lisp-mode-hook "el")
  (diminish-major-mode 'python-mode-hook "Py"))

(use-package yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode)))

(provide 'extensions)