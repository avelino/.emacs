(use-package nim-mode)

(add-hook 'nim-mode-hook 'nimsuggest-mode) ; TL;DR
(add-hook 'nimsuggest-mode-hook 'flycheck-mode) ; auto linter package

(provide 'nim-lang)
