;;; python-lang.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;; REQUIREMENTS:
;; pip install rope
;; pip install jedi
;; pip install flake8
;; pip install autopep8
;; pip install yapf
;; pip install ipython
;;
;;; Code:


(use-package elpy
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
  :bind (:map elpy-mode-map
	      ("<M-left>" . nil)
	      ("<M-right>" . nil)
	      ("<M-S-left>" . elpy-nav-indent-shift-left)
	      ("<M-S-right>" . elpy-nav-indent-shift-right)
	      ("M-." . elpy-goto-definition)
	      ("M-," . pop-tag-mark)
	      ("C-c C-s" . nil))
  :config
  (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
  (setenv "IPY_TEST_SIMPLE_PROMPT" "1")
  (setq
   elpy-rpc-backend "jedi"
   flycheck-python-flake8-executable "flake8"
   python-shell-interpreter "ipython3"
   python-shell-interpreter-args "-i"))

(use-package pyvenv
  :ensure t)

(use-package blacken
  :ensure t)

(use-package python
  :disabled
  :ensure t
  :mode ("\\.py" . python-mode)
  :config
  (add-hook 'python-mode-hook 'blacken-mode)
  (setq python-indent-offset 4)
  (elpy-enable))

(use-package pip-requirements
  :ensure t
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(use-package py-autopep8
  :ensure t)

(use-package ein
  :ensure t)

(provide 'python-lang)

;;; python-lang.el ends here
