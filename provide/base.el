;;; base.el --- Avelino base for Emacs

;;; Commentary:
;;
;;; Code:

(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(defconst private-dir (expand-file-name "private" user-emacs-directory))
(defconst temp-dir (format "%s/cache" private-dir))

;; Core settings
;; UTF-8 please
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-charset-priority 'unicode)
(setq locale-coding-system          'utf-8
      default-process-coding-system '(utf-8-unix . utf-8-unix))   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)

(setq
 confirm-kill-emacs                  'y-or-n-p
 inhibit-splash-screen               t
 initial-scratch-message             ""
 confirm-nonexistent-file-or-buffer  t
 save-interprogram-paste-before-kill t
 mouse-yank-at-point                 t
 inhibit-splash-screen               t
 inhibit-startup-message             t
 require-final-newline               nil
 visible-bell                        nil
 ring-bell-function                  'ignore
 custom-file                         "~/.emacs.d/.custom.el"
 ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
 minibuffer-prompt-properties        '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)
 ;; persistent bookmarks
 bookmark-save-flag                  t
 bookmark-default-file               (concat temp-dir "/bookmarks")
 ;; Disable backups (that's what git/dropbox are for)
 history-length                      1000
 auto-save-default                   nil
 auto-save-list-file-name            (concat temp-dir "/autosave")
 make-backup-files                   nil
 create-lockfiles                    nil
 backup-directory-alist              `((".*" . ,(concat temp-dir "/backup/")))
 auto-save-file-name-transforms      `((".*" ,(concat temp-dir "/auto-save-list/") t))
 ;; Disable non selected window highlight
 cursor-in-non-selected-windows      nil
 highlight-nonselected-windows       nil
 ;; PATH
 exec-path                           (append exec-path '("/Users/avelino/bin"))
 ;; Backups disabled
 backup-inhibited                    t
 make-backup-files                   nil
 indent-tabs-mode                    nil
 inhibit-startup-message             t
 fringes-outside-margins             t
 x-select-enable-clipboard           t
 use-package-always-ensure           t
 vc-follow-symlinks                  t
 auto-revert-check-vc-info           nil
 frame-resize-pixelwise              t
 ;; mode line settings
 line-number-mode                    t
 column-number-mode                  t
 size-indication-mode                t
 ;; shell
 shell-prog                          "/bin/zsh"
 explicit-shell-file-name            shell-prog
 multi-term-program                  shell-prog
 term-buffer-maximum-size            10000
 show-trailing-whitespace            nil
 comint-prompt-read-only             t
 default-frame-alist                 '((font . "Fira Code-18"))
 fill-prefix                         "")

;; Disable toolbar & menubar
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Env vars
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
(setenv "SHELL" shell-prog)

(show-paren-mode 1)
(desktop-save-mode 0)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Fullscreen: call `toggle-frame-fullscreen'
(toggle-frame-fullscreen)

;; Highlight BUG FIXME TODO NOTE keywords in the source code.
(add-hook 'find-file-hook
	  (lambda()
            (highlight-phrase "\\(BUG\\|FIXME\\|TODO\\|NOTE\\):")))

;; Term
(add-hook 'term-mode-hook
          (lambda ()
            (setq show-trailing-whitespace nil)
            (autopair-mode -1)))

(provide 'base)
;;; base.el ends here
