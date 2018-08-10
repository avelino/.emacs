;;; jvm-lang.el --- Avelino jvm languages for Emacs

;;; Commentary:
;;
;;; Code:


;;; code:
;; (use-package java-mode)

;; Clojure
(use-package clojure-mode
  :config
  (add-hook 'clojure-mode-hook 'subword-mode))
(use-package cljsbuild-mode)
(use-package cider
  :config
  (add-hook 'cider-mode-hook 'eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'subword-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode))
(use-package flycheck-clojure)

;; (use-package kotlin-mode)

(provide 'jvm-lang)

;;; jvm-lang.el ends here
