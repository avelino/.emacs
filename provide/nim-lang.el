;;; nim-lang.el --- Avelino nim for Emacs

;;; Commentary:
;;
;;; Code:

(use-package nim-mode)

(add-hook 'nim-mode-hook 'nimsuggest-mode) ; TL;DR
(add-hook 'nimsuggest-mode-hook 'flycheck-mode) ; auto linter package

(provide 'nim-lang)

;;; nim-lang.el ends here
