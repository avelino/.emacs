; package --- Main init file
;;; Commentary:
;;; avelino's GNU Emacs configuration
;;; This is my init file

;;; Code:

(add-to-list 'load-path (concat user-emacs-directory "provide"))
(add-to-list 'load-path (concat user-emacs-directory "vendor"))
(add-to-list 'load-path (concat user-emacs-directory "local")) ;; not remote repository

;; basic packages: initial configuration (basic)
(require 'base)
(require 'keys)
(require 'functions)
(require 'ui)
(require 'extensions)
(require 'aliases)

;; languages
(require 'c-lang)
(require 'elixir-lang)
(require 'go-lang)
(require 'haskell-lang)
(require 'python-lang)
(require 'web-lang)
(require 'lisp-lang)
(require 'dut-mode)
(require 'rum-lang)
;; (require 'jvm-lang)
(require 'nim-lang)
(require 'sql-lang)

;; nothers
(require 'writer)

;;; init.el ends here
