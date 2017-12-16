(setq ns-function-modifier 'control)
;; Set global keys not specific to a certain package
;(global-set-key (kbd "M-f") (lambda () (interactive) (forward-word)))
;(global-set-key (kbd "M-b") (lambda () (interactive) (backward-word)))
(global-set-key (read-kbd-macro "<M-DEL>") 'backward-delete-word)
(global-set-key (kbd "C-d") 'delete-word)

(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\C-a" 'smart-beginning-of-line)

(global-set-key (kbd "C-x 2") 'split-window-below-and-switch)
(global-set-key (kbd "C-x 3") 'split-window-right-and-switch)

(global-set-key (kbd "C-x C-b") 'switch-to-buffer)

;; Custom Emacs Shortcuts
(global-set-key (kbd "M-<") (lambda () (interactive) (beginning-of-buffer-record)))
(global-set-key (kbd "M->") (lambda () (interactive) (end-of-buffer-record)))
(global-set-key (kbd "M-/") (lambda () (interactive) (go-back-to-point)))
(global-set-key (kbd "C-}") (lambda () (interactive) (forward-line 5)))
(global-set-key (kbd "C-{") (lambda () (interactive) (forward-line -5)))
(global-set-key (kbd "M-S-<up>") (lambda () (interactive) (codenav-prev-definition)))
(global-set-key (kbd "M-S-<down>") (lambda () (interactive) (codenav-next-definition)))

;; iTerm2
(global-set-key (kbd "C-'") 'iterm-focus)

;; rgrep
(global-set-key (kbd "C-x c g") (lambda () (interactive) (call-interactively 'rgrep)))
(define-key ctl-x-r-map "b" 'bookmark-jump-or-find-file)

;; Mac
;; (when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-right-option-modifier 'super)
  ;; sets fn-delete to be right-delete
  (global-set-key [kp-delete] 'delete-char)
  (setq-default default-input-method "MacOSX")
  ;; Make mouse wheel / trackpad scrolling less jerky
  (setq mouse-wheel-scroll-amount '(1
                                    ((shift) . 5)
                                    ((control))))
  (dolist (multiple '("" "double-" "triple-"))
    (dolist (direction '("right" "left"))
      (global-set-key (read-kbd-macro (concat "<" multiple "wheel-" direction ">")) 'ignore)))
;;  )

(provide 'keys)
