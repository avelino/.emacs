;;; rum-mode.el --- Major mode for Rum code

;; Copyright (C) 2017 Rum Language
;;
;; Authors: Avelino <t@avelino.xxx>
;; URL: https://github.com/rumlang/rum-mode
;; Version: 1.0
;; Keywords: rum, languages, lisp

;; This file is not part of GNU Emacs.


;;; Code:

(require 'cl)

(defconst rum-font-lock-keywords
  (list
   '("\\<\\(package\\|break\\|continue\\|for\\|if\\|else\\|import\\|let\\|map\\|return\\|struct\\|def\\|case\\|default\\|print\\|sprintf\\|def\\|lambda\\|array\\)\\>" . font-lock-builtin-face)
   '("\\<\\(struct\\)\\s-+\\(\\w+\\)\\>" (1 font-lock-keyword-face) (2 font-lock-type-face))
   '("\\<\\(def\\)\\s-+\\(\\w+\\)\\>" (1 font-lock-keyword-face) (2 font-lock-function-name-face))))

(define-derived-mode rum-mode lisp-mode "rum"
  "Major mode for editing rum script"
  (set (make-local-variable 'font-lock-defaults) '(rum-font-lock-keywords)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.rum$" . rum-mode))

(provide 'rum-mode)
;;; rum-mode.el ends here
