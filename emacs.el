(require 'helm)
(require 'helm-config)
(require 'sr-speedbar)
(require 'recentf)
(require 'spaceline-config)
(require 'which-key)
(require 'auto-complete-config)

(if window-system
      (custom-set-variables
       ;; custom-set-variables was added by Custom.
       ;; If you edit it by hand, you could mess it up, so be careful.
       ;; Your init file should contain only one such instance.
       ;; If there is more than one, they won't work right.
       '(custom-enabled-themes (quote (spacemacs-dark)))
       '(custom-safe-themes
         (quote
          ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476")))))

(custom-set-variables
 '(menu-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(widget-button ((t (:foreground "gray90" :underline nil :weight bold)))))

;; Disable toolbar & menubar
(menu-bar-mode -1)
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
  (when (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))


;; Enable modes
(projectile-global-mode)
(global-linum-mode nil)
(recentf-mode 1)
(spaceline-emacs-theme)
(show-paren-mode 1)
(which-key-mode)
(ac-config-default)
(global-git-gutter+-mode)
(yas-global-mode 1)
(helm-mode 1)

;; Env vars
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))

;; Variables
(setq exec-path (append exec-path '("/usr/local/bin/")))
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq inhibit-startup-message t)
(setq sr-speedbar-right-side nil)
(setq speedbar-smart-directory-expand-flag t)
(setq make-backup-files nil)
(setq-default indent-tabs-mode nil)

(setq x-select-enable-clipboard t
      save-interprogram-paste-before-kill t
      mouse-yank-at-point t
      require-final-newline t
      visible-bell t
      load-prefer-newer t
      backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))

;; Custom line number stuff
(setq linum-format 'dynamic)
(setq-default left-fringe-width  12)
(setq-default right-fringe-width  0)
(set-face-attribute 'fringe nil)

;; Delete trailing whitespace before save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Flycheck enable
(add-hook 'after-init-hook #'global-flycheck-mode)

; (require 'spacemacs-startup)
; (spacemacs/setup-startup-hook)