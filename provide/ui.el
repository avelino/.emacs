;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

(use-package monokai-theme)
;; (use-package color-theme-sanityinc-tomorrow) ;; used to clear (white) terminal active
;; (use-package rebecca-theme)
;; (use-package material-theme)

(use-package color-identifiers-mode
  :init
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

(provide 'ui)

;;; ui.el ends here
