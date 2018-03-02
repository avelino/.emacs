;;; sql-lang.el --- Avelino SQL for Emacs

;;; Commentary:
;;
;;; Code:

(add-to-list 'auto-mode-alist '("\\.psql$" . sql-mode))
(add-to-list 'auto-mode-alist '("\\.sql$" . sql-mode))

(use-package sql-indent)

(provide 'sql-lang)
;;; sql.el ends here
