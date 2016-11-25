(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defconst private-dir  (expand-file-name "private" user-emacs-directory))
(defconst temp-dir
  (format "%s/cache" private-dir)
  "Hostname-based elisp temp directories")

;; Core settings
;; UTF-8 please
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

(setq confirm-kill-emacs                  'y-or-n-p
      confirm-nonexistent-file-or-buffer  t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point                 t
      require-final-newline              nil
      visible-bell                       nil
      ring-bell-function                 'ignore
      custom-file                        "~/.emacs.d/.custom.el"
      ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
      minibuffer-prompt-properties
      '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)
      ;; persistent bookmarks
      bookmark-save-flag                 t
      bookmark-default-file              (concat temp-dir "/bookmarks")
      ;; Disable backups (that's what git/dropbox are for)
      history-length                     1000
      auto-save-default                  nil
      auto-save-list-file-name           (concat temp-dir "/autosave")
      make-backup-files                  nil
      create-lockfiles                   nil
      backup-directory-alist            `((".*" . ,(concat temp-dir "/backup/")))
      auto-save-file-name-transforms    `((".*" ,(concat temp-dir "/auto-save-list/") t))
      ;; Remember undo history
      undo-tree-auto-save-history        nil
      undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/")))
      ;; Disable non selected window highlight
      cursor-in-non-selected-windows     nil
      highlight-nonselected-windows      nil
      ;; PATH
      exec-path                          (append exec-path '("/usr/local/bin/"))
      ;; Backups disabled
      backup-inhibited                   t
      make-backup-files                  nil
      indent-tabs-mode                   nil
      inhibit-startup-message            t
      fringes-outside-margins            t
      x-select-enable-clipboard          t
      use-package-always-ensure          t
      vc-follow-symlinks                 t
      auto-revert-check-vc-info          t)

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

;; Disable toolbar & menubar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (  fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Env vars
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/:$GOPATH"))
(setenv "SHELL" "/bin/zsh")

(show-paren-mode 1)
(desktop-save-mode 0)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'auto-mode-alist '("\\.psql$" . sql-mode))

(provide 'core)
;;; core ends here
