;;; jvm-lang.el --- Avelino jvm languages for Emacs

;;; Commentary:
;;
;;; Code:


;;; code:
;; (use-package java-mode)

;; Clojure
(use-package clojure-mode
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'subword-mode))
(use-package cljsbuild-mode
  :ensure t)
(use-package cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'subword-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))
(use-package ac-cider
  :ensure t
  :config
  (add-hook 'cider-mode-hook 'ac-flyspell-workaround)
  (add-hook 'cider-mode-hook 'ac-cider-setup)
  (add-hook 'cider-repl-mode-hook 'ac-cider-setup)
  (eval-after-load "auto-complete"
    '(progn
       (add-to-list 'ac-modes 'cider-mode)
       (add-to-list 'ac-modes 'cider-repl-mode))))
(use-package flycheck-clojure
  :ensure t)

;; (use-package kotlin-mode)

(provide 'jvm-lang)

;;; jvm-lang.el ends here
