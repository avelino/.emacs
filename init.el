;;; package --- Main init file
;;; Commentary:
;;; avelino's GNU Emacs configuration
;;; This is my init file

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "provide"))
(add-to-list 'load-path (concat user-emacs-directory "vendor"))

;; basic packages
(require 'base)
(require 'extensions)
(require 'functions)
(require 'shell)
(require 'aliases)
(require 'keys)
(require 'ui)

;; languages
(require 'c-lang)
(require 'elixir-lang)
(require 'go-lang)
(require 'haskell-lang)
(require 'python-lang)
(require 'web-lang)
(require 'lisp-lang)
(require 'dut-mode)
