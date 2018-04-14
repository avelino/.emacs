;;; writer.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;;; Code:

(use-package markdown-mode
  :ensure t
  :commands
  (markdown-mode gfm-mode)
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "multimarkdown"))

(use-package markdownfmt
  :config
  (add-hook 'markdown-mode-hook #'markdownfmt-enable-on-save)
  :bind
  ("C-c C-f" . markdownfmt-format-buffer))

(use-package deft
  :config
  (setq deft-extensions '("md" "txt" "tex" "org"))
  (setq deft-directory "~/Dropbox/Notes"))

(use-package 'taskpaper-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.papertask\\'" . taskpaper-mode))
  (add-to-list 'auto-mode-alist '("\\.todo\\'" . taskpaper-mode))
  (setq taskpaper-tag-faces
	'(("done"    . (:foreground "green" :weight bold :underline t))
	  ("waiting" . (:foreground "purple" :weight bold :underline t))
	  ("today"   . (:foreground "blue" :weight bold :underline t))
	  ("flagged" . (:foreground "red" :weight bold :underline t))
	  ("due"     . (:foreground "orange" :weight bold :underline t)))))

(use-package apib-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.apib\\'" . apib-mode)))

(provide 'writer)

;;; writer.el ends here
