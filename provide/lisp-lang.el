;;; lisp-lang.el --- Avelino lisp-lang for Emacs

;;; Commentary:
;;
;;; Code:

;; Lisp
(use-package lisp-mode
  :disabled
  :ensure t
  :bind (:map emacs-lisp-mode-map
              ("M-n" . highlight-symbol-next)
              ("M-p" . highlight-symbol-prev)
              ("M-." . find-symbol-at-point)
              ("C-c e" . eval-last-sexp-other-buffer)
              ("C-M-w" . backward-kill-sexp)
              ("C-M-d" . kill-sexp)))

(use-package aggressive-indent
  :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode))

(use-package flycheck-elsa
  :disabled
  :config
  (add-hook 'emacs-lisp-mode-hook #'flycheck-elsa-setup))

;; Racket
(use-package racket-mode
  :ensure t
  :config
  (add-hook 'racket-mode-hook
	    (lambda ()
	      (define-key racket-mode-map (kbd "C-c r") 'racket-run)))
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)
  (setq tab-always-indent 'complete))
(use-package flymake-racket
  :ensure t
  :commands (flymake-racket-add-hook)
  :init
  (add-hook 'scheme-mode-hook #'flymake-racket-add-hook)
  (add-hook 'racket-mode-hook #'flymake-racket-add-hook))

;; Scheme
(use-package geiser)

(provide 'lisp-lang)

;;; lisp-lang.el ends here
