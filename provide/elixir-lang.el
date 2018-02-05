;;; elixir-lang.el --- Avelino elixer for Emacs

;;; Commentary:
;;
;;; Code:

(use-package alchemist
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(use-package flycheck-elixir)

(use-package flycheck-mix
  :commands (flycheck-mix-setup))

(use-package elixir-mode)

(provide 'elixir-lang)

;;; elixir-lang.el ends here
