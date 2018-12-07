;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

;; (use-package monokai-theme)
;; (use-package dracula-theme)
(use-package doom-themes
  :defer t
  :init (load-theme 'doom-molokai t))
;; (load-theme 'ayu-theme t) ;; local [WIP] ref: https://github.com/dempfi/ayu
;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-light t))

(use-package color-identifiers-mode
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

;; smart-mode-line
(use-package smart-mode-line
  :ensure t
  :requires all-the-icons
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; All the icons
(use-package all-the-icons
  :ensure t
  :config
  ;; The below command needs to be run only once manually to install the
  ;; needed fonts (all-the-icons-install-fonts)
  )

;; Utility package that return vscode icons for Emacs
(use-package vscode-icon
  :ensure t
  :defer t
  :commands
  (vscode-icon-for-file))


(use-package nlinum
  :hook (prog-mode . nlinum-mode)
  :config
  (setq nlinum-format "%4d "
	nlinum-highlight-current-line 't))

(provide 'ui)

;;; ui.el ends here
