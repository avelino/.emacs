;;; ui.el --- Avelino UI for Emacs

;;; Commentary:
;;
;;; Code:

;; `window-divider-mode' gives us finer control over the border between windows.
;; The native border "consumes" a pixel of the fringe on righter-most splits (in
;; Yamamoto's emacs-mac at least), window-divider does not. You can also control
;; vertical borders between windows (introduced in Emacs 25.1+)
(when (boundp 'window-divider-mode)
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1)
  (window-divider-mode +1))

(use-package all-the-icons
  :config
  (insert (all-the-icons-icon-for-file "*.*")))

;; (use-package monokai-theme)
(use-package color-theme-sanityinc-tomorrow)
;; (use-package nord-theme)
;; (use-package flatui-theme)

(use-package color-identifiers-mode
  :init
  ;; (add-hook 'emacs-lisp-mode-hook #'color-identifiers-mode)
  (add-hook 'after-init-hook 'global-color-identifiers-mode)
  :diminish color-identifiers-mode)

(use-package git-gutter)
(use-package git-gutter-fringe+)
(use-package git-gutter+
  :config
  (require 'git-gutter-fringe+)
  (set-face-attribute 'fringe nil :background nil)
  (global-git-gutter-mode +1)
  (define-fringe-bitmap 'git-gutter-fr:added
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:modified
    [224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224 224]
    nil nil 'center)
  (define-fringe-bitmap 'git-gutter-fr:deleted
    [0 0 0 0 0 0 0 0 0 0 0 0 0 128 192 224 240 248]
    nil nil 'center)

  (add-hook 'focus-in-hook 'git-gutter:update-all-windows))

(setq fringes-outside-margins t
      highlight-nonselected-windows nil)

(define-fringe-bitmap 'flycheck-fringe-bitmap-double-arrow
  [0 0 0 0 0 4 12 28 60 124 252 124 60 28 12 4 0 0 0 0])

;; Custom line number stuff
(set-face-attribute 'fringe nil)

(use-package powerline
  :config
  (eval-when-compile (require 'powerline))
  (defvar mode-line-height 30)
  (defvar mode-line-bar          (pl/percent-xpm mode-line-height 100 0 100 0 3 "#00B3EF" nil))
  (defvar mode-line-eldoc-bar    (pl/percent-xpm mode-line-height 100 0 100 0 3 "#B3EF00" nil))
  (defvar mode-line-inactive-bar (pl/percent-xpm mode-line-height 100 0 100 0 3 nil nil))
  (defface mode-line-is-modified nil "Face for mode-line modified symbol")
  (defface mode-line-buffer-path nil "Face for mode-line buffer file path")
  (defface mode-line-highlight nil "")
  (defface mode-line-2 nil "")
  (defvar mode-line-selected-window nil))

(provide 'ui)

;;; ui.el ends here
