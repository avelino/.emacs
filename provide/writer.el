;;; writer.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;;; Code:

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdownfmt
  :config
  (add-hook 'markdown-mode-hook #'markdownfmt-enable-on-save)
  :bind
  ("C-c C-f" . markdownfmt-format-buffer))

(use-package deft
  :config
  (setq deft-extensions '("md" "txt" "tex" "org"))
  (setq deft-directory "~/Dropbox/Notes"))

;; (use-package taskpaper-mode) ;; not yet Melpa repo - https://github.com/melpa/melpa/pull/5349
(require 'taskpaper-mode)
(add-to-list 'auto-mode-alist '("\\.papertask\\'" . taskpaper-mode))
(add-to-list 'auto-mode-alist '("\\.todo\\'" . taskpaper-mode))
(setq taskpaper-tag-faces
      '(("done"    . font-lock-type-face)
        ("today"   . font-lock-keyboard-face)
	("flagged" . font-lock-warning-face)
        ("due"     . font-lock-variable-face)))

(provide 'writer)

;;; writer.el ends here
