;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

;; theme: dark
;; (use-package monokai-theme
;;   :ensure t
;;   :init
;;   (load-theme 'monokai t))

(use-package dracula-theme
 :ensure t
 :init
 (load-theme 'dracula t))

;; (use-package kaolin-themes
;;   :ensure t
;;   :defer t
;;   :init (load-theme 'kaolin-bubblegum t))

;; theme: light
;; (use-package almost-mono-themes
;;   :defer t
;;   :config
;;   (load-theme 'almost-mono-white t))
;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-light t))
;; (use-package one-themes
;;   :defer t
;;   :init
;;   (load-theme 'one-light t))

(use-package color-identifiers-mode
  :ensure t
  :diminish (color-identifiers-mode . "🎨 ")
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; All the icons
(use-package all-the-icons
  :ensure t)

;; smart-mode-line
(use-package smart-mode-line
  :ensure t
  :requires all-the-icons
  :config
  (setq sml/no-confirm-load-theme t
	sml/theme 'dark)
  (sml/setup))


;; Utility package that return vscode icons for Emacs
(use-package vscode-icon
  :ensure t
  :defer t
  :commands
  (vscode-icon-for-file))

(use-package hlinum
  :config
  (hlinum-activate))
(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))
(use-package nlinum-hl
  :ensure t
  :config
  (setq nlinum-highlight-current-line t))

;(use-package ergoemacs-status
;  :ensure t
;  :config
;  (ergoemacs-status-mode))

(use-package spaceline-config           ; A beautiful mode line
  :ensure spaceline
  :config
  (spaceline-emacs-theme))

(use-package powerline                  ; The work-horse of Spaceline
  :ensure t
  :after spaceline-config
  :config (setq
           powerline-height (truncate (* 1.0 (frame-char-height)))
           powerline-default-separator 'utf-8))

(use-package fill-column-indicator
  :ensure t
  :config
  (fci-mode))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq centaur-tabs-set-bar 'over
	centaur-tabs-modified-marker "*"
	centaur-tabs-set-icons t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(provide 'ui)

;;; ui.el ends here
