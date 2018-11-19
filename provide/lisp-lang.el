;;; lisp-lang.el --- Avelino lisp-lang for Emacs

;;; Commentary:
;;
;;; Code:

;; Lisp
(use-package lisp-mode
  :ensure nil
  :bind (:map emacs-lisp-mode-map
              ("M-n" . highlight-symbol-next)
              ("M-p" . highlight-symbol-prev)
              ("M-." . find-symbol-at-point)
              ("C-c e" . eval-last-sexp-other-buffer)
              ("C-M-w" . backward-kill-sexp)
              ("C-M-d" . kill-sexp)))

(use-package flycheck-elsa
  :config
  (add-hook 'emacs-lisp-mode-hook #'flycheck-elsa-setup))

;; Racket
(use-package racket-mode
  :config
  (add-hook 'racket-mode-hook
	    (lambda ()
	      (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (setq tab-always-indent 'complete))

;; Scheme
(use-package geiser)

(provide 'lisp-lang)

;;; lisp-lang.el ends here
