(use-package alchemist
  :config
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(use-package flycheck-elixir)

(use-package flycheck-mix
  :commands (flycheck-mix-setup))

(use-package elixir-mode)

(provide 'elixir-lang)