;;; lisp-lang.el --- Avelino lisp-lang for Emacs

;;; Commentary:
;;
;;; Code:

(use-package lisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
              ("M-n" . highlight-symbol-next)
              ("M-p" . highlight-symbol-prev)
              ("M-." . find-symbol-at-point)
              ("C-c e" . eval-last-sexp-other-buffer)
              ("C-M-w" . backward-kill-sexp)
              ("C-M-d" . kill-sexp))

(provide 'lisp-lang)

;;; lisp-lang.el ends here
