;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

;; (use-package monokai-theme)
(use-package dracula-theme)
;; (use-package spacemacs-theme
;;   :defer t
;;   :init (load-theme 'spacemacs-light t))

(use-package color-identifiers-mode
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

(use-package diff-hl
  :init (global-diff-hl-mode)
  :config (add-hook 'vc-checkin-hook 'diff-hl-update))

(provide 'ui)

;;; ui.el ends here
