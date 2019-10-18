;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

;; theme: dark
;; (use-package monokai-theme)
(use-package dracula-theme)
;; (use-package kaolin-themes
;;   :ensure t
;;   :defer t
;;   :init (load-theme 'kaolin-bubblegum t))

;; theme: light
;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-light t))

(use-package color-identifiers-mode
  :ensure t
  :diminish (color-identifiers-mode . "🎨 ")
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; smart-mode-line
(use-package smart-mode-line
  :ensure t
  :requires all-the-icons
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; All the icons
(use-package all-the-icons
  :ensure t)

;; Utility package that return vscode icons for Emacs
(use-package vscode-icon
  :ensure t
  :defer t
  :commands
  (vscode-icon-for-file))

(use-package nlinum
  :ensure t
  :hook (prog-mode . nlinum-mode)
  :config
  (setq nlinum-format "%4d "
	nlinum-highlight-current-line 't))

(use-package git-gutter-fringe+
  :ensure t
  :config
  (global-git-gutter+-mode t))

(use-package ergoemacs-status
  :ensure t
  :config
  (ergoemacs-status-mode))

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

(provide 'ui)

;;; ui.el ends here
