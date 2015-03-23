;;; .emacs -- d11wtq's configuration file

;;; --- Bootstrap

(when (version< emacs-version "24.1")
  (error "Prelude requires at least GNU Emacs 24.1, but you're running %s" emacs-version))

;; elpa package management
(require 'package)

;; common lispy things
(require 'cl)

;; melpa (github-based) source
(add-to-list 'package-archives
  '("melpa" .
      "http://melpa.milkbox.net/packages/"))

;; marmalade source
(add-to-list 'package-archives
  '("marmalade" .
      "http://marmalade-repo.org/packages/"))

;; start the package system
(package-initialize)

;; Specify a dependency (auto-install)
(defun dep (depname)
  "Require or install a dependency as needed."
  (interactive)
  (unless (package-installed-p depname)
    (install-dep depname nil)))

;; Convenience around `package-install'.
(defun install-dep (depname refresh)
  "Runs `package-install', attempting `package-refresh-contents' on failure."
  (when refresh (package-refresh-contents))
  (condition-case err
      (package-install depname)
    (error (if refresh
               (signal (car err) (cdr err))
             (install-dep depname t)))))

;; Specify a list of dependencies
(defun dependencies (deps)
  "Convenience around `dep' to load multiple deps."
  (unless (eq '() deps)
    (dep (car deps))
    (dependencies (cdr deps))))

;; Macro to return an interactive lambda.
(defmacro run (cmd)
  `(lambda () (interactive) ,cmd))

;;; -- Dependencies

(dependencies '(molokai-theme
                evil
                evil-numbers
                paredit
                auto-complete
                markdown-mode
                yaml-mode
                slime
                fiplr
                python-mode
                py-autopep8
                git-gutter-fringe
                fill-column-indicator
                go-mode
                company-go
                go-eldoc
                go-projectile
                gotest))

;; Do what I mean for the TAB key.
(defun dwim-tab ()
  "In most cases, performs the default action for the TAB key.
If pressing TAB would do nothing, indents by one tab stop."
  (interactive)
  (when (or (eq last-command this-command)
            (= (point) (progn
                         (indent-for-tab-command)
                         (point))))
    (tab-to-tab-stop)))

;; dwim-tab-mode for logical tab key behaviour
(define-minor-mode dwim-tab-mode
  "Toggle dwim-tab-mode on/off.
Given a non-nil argument, enables dwim-tab.
With dwim-tab-mode enabled, pressing TAB multiple times continues to indent."
  :lighter " DWIM"
  :global  t
  :keymap  `((,(kbd "TAB") . dwim-tab)))

;; no fucking latin-1, thank you very much
(mapc (lambda (fn) (funcall fn 'utf-8))
      '(set-terminal-coding-system
        set-keyboard-coding-system
        prefer-coding-system))

;;; -- Config

;; make pretty colors
(load-theme 'molokai t)

;; emacs is actually vim in disguise
(evil-mode t)

;; show the column number in the status bar
(column-number-mode t)

;; turn on ido mode everywhere
(ido-mode t)

;; show matching braces
(show-paren-mode t)

;; the menu bar is pointless in a terminal
(menu-bar-mode -1)

;; don't show the tool bar when in a gui
(when (featurep 'tool-bar)
  (tool-bar-mode -1))

;; turn on auto-completion of function names etc
(require 'auto-complete)
(global-auto-complete-mode t)

;; global key mappings
(mapc (lambda (mapping)
        (global-set-key (kbd (car mapping)) (cdr mapping)))
      `(;; toggle line numbers
        ("C-x j"   . ,(run (linum-mode (or (not linum-mode) -1))))
        ;; open ~/.emacs.d/init.el
        ("C-x /"   . ,(run (find-file user-init-file)))
        ;; run an emacs command
        ("C-x SPC" . execute-extended-command)
        ;; run a lisp expression
        ("C-x ,"   . eval-expression)
        ;; find file in project
        ("C-x f"   . fiplr-find-file)))

;; evil normal mode key mappings
(mapc (lambda (mapping)
        (define-key evil-normal-state-map (kbd (car mapping)) (cdr mapping)))
      `(;; increment number under point
        ("C-k"   . evil-numbers/inc-at-pt)
        ;; decrement number under point
        ("C-j"   . evil-numbers/dec-at-pt)))

;; allow the arrow keys to be used for cycling windows
(mapc (lambda (keys)
        (let ((letter (format "C-w %s" (car keys)))
              (arrow  (format "C-w %s" (cdr keys))))
          (define-key evil-normal-state-map (kbd arrow) (kbd letter))
          (define-key evil-motion-state-map (kbd arrow) (kbd letter))
          (define-key evil-visual-state-map (kbd arrow) (kbd letter))))
      '(("h" . "<left>")
        ("j" . "<down>")
        ("k" . "<up>")
        ("l" . "<right>")))

;; show whitespace...
(global-whitespace-mode t)

;; reload changes from disk
(global-auto-revert-mode t)

;; customize some global vars
(custom-set-variables
 ;; by default evil binds C-z
 '(evil-toggle-key (kbd "C-\\"))
 ;; fuck #autosave# files
 '(auto-save-default nil)
 ;; fuck backup~ files
 '(make-backup-files nil)
 ;; put newlines at the end of files
 '(require-final-newline t)
 ;; don't scroll by huge amounts near the edge of window
 '(scroll-step 1)
 ;; don't do anything if the point leaves the screen (it won't)
 '(scroll-conservatively 1000)
 ;; fuzzy searching in ido
 '(ido-enable-flex-matching t)
 ;; soft tabs in most places
 '(indent-tabs-mode nil)
 ;; 4 spaces is a nice true tab size
 '(tab-width 4)
 ;; 2 spaces is a nice indent amount
 '(tab-stop-list (number-sequence 2 200 2))
 ;; evil-mode indent 2 spaces when shifting
 '(evil-shift-width 2)
 ;; auto-complete on tab key
 '(ac-trigger-key "TAB")
 ;; only auto-complete when asked
 '(ac-auto-start nil)
 ;; only show trailing whitespace
 '(whitespace-style '(face trailing))
 ;; *-mode wants to add # -* coding: utf-8 -* everywhere: fuck off
 '(python-insert-encoding-magic-comment nil)
 '(ruby-insert-encoding-magic-comment nil)
 ;; ruby-mode's default indentation is hideous
 '(ruby-deep-indent-paren nil)
 '(fill-column 79))

(setq fiplr-ignored-globs
    '((directories (".git" ".svn"))
      (files ("*.pyc"))))

;; treat underscores as word chars
(modify-syntax-entry ?_ "w")

;; .md files should use markdown-mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; make python-mode indentation vaguely sane
(add-hook 'python-mode-hook
  (lambda ()
    (setq tab-width 4)
    (setq evil-shift-width 4)))

(add-hook 'before-save-hook 'py-autopep8-before-save)

(global-git-gutter-mode t)

;; magic to change the mode-line color according to state
(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook
    (lambda ()
      (let ((color (cond ((minibufferp) default-color)
                         ((evil-insert-state-p) '("#e80000" . "#ffffff"))
                         ((evil-emacs-state-p)  '("#af00d7" . "#ffffff"))
                         ((buffer-modified-p)   '("#006fa0" . "#ffffff"))
                         (t default-color))))
        (set-face-background 'mode-line (car color))
        (set-face-foreground 'mode-line (cdr color))))))

;; 79 limit line marker
(setq fci-rule-width 2)
(setq fci-rule-color "darkred")
(setq-default fci-rule-column 79)
(setq fci-handle-truncate-lines nil)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
(defun auto-fci-mode (&optional unused)
   (if (> (window-width) fci-rule-column)
      (fci-mode 1)
      (fci-mode 0))
 )
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-configuration-change-hook 'auto-fci-mode)

;;; -- User config

(let ((custom-config "~/.emacs.d/custom.el"))
  (when (file-exists-p custom-config)
    (load custom-config)))

;;; .emacs ends here
