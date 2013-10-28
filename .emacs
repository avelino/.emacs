(custom-set-variables
 '(backup-by-copying t)
 '(backup-directory-alist (quote (("~/.emacs_backups"))))
 '(word-wrap t))

;;; line numbers.
(line-number-mode t)
(global-linum-mode 1)

;;; Setup larger line number thingy
(setq line-number-display-limit 1000000)

;;; arg >= 1 enable the menu bar. Menu bar is the File, Edit, Options,
;;     Buffers, Tools, Emacs-Lisp, Help
(menu-bar-mode 0)

;;; theme setup
(add-to-list 'load-path "~/.emacs.d/themes/")
(setq load-dangerous-libraries t)
(require 'color-theme)
(require 'color-theme-molokai)
(color-theme-molokai)

;;; require plugin
(add-to-list 'load-path "~/.emacs.d/")

;;; load emacs-for-python
(load-file "~/.emacs.d/emacs-for-python/epy-init.el")
(epy-setup-checker "pyflakes %f")
(epy-django-snippets)
(epy-setup-ipython)
(require 'highlight-indentation)
(add-hook 'python-mode-hook 'highlight-indentation)

;;; load git-guntter
(add-to-list 'load-path "~/.emacs.d/emacs-git-guntter/")
(require 'git-gutter)
(global-git-gutter-mode +1)
(add-hook 'ruby-mode-hook 'git-gutter-mode)
(add-hook 'python-mode-hook 'git-gutter-mode)

;;; load emacs-nav
(add-to-list 'load-path "~/.emacs.d/emacs-nav/")
(require 'nav)

;;; load web-mode
(add-to-list 'load-path "~/.emacs.d/web-mode/")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))