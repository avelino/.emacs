;;; clj-lang.el --- Avelino clj-lang for Emacs

;;; Commentary:
;;
;;; Code:

;; Clojure(Script)
(use-package clojure-mode
  :disabled
  :ensure t
  :config
  (add-hook 'clojure-mode-hook 'subword-mode))

(use-package cljsbuild-mode
  :disabled
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

(provide 'clj-lang)
