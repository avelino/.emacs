;;; python-lang.el --- Avelino extensions for Emacs

;;; Commentary:
;;
;; REQUIREMENTS:
;; pip install rope
;; pip install jedi
;; pip install flake8
;; pip install autopep8
;; pip install yapf
;;
;;; Code:

(use-package elpy
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
    flycheck-python-flake8-executable "/usr/local/bin/flake8"
    (setq elpy-rpc-backend "jedi"))

(use-package python
  :mode ("\\.py" . python-mode)
  :config
  (setq python-indent-offset 4)
  (elpy-enable))

(use-package pip-requirements
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(use-package py-autopep8)

(provide 'python-lang)

;;; python-lang.el ends here
