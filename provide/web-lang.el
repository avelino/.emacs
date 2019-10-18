;;; web-lang.el --- Avelino web langagues for Emacs

;;; Commentary:
;;
;;; Code:

(use-package web-mode
  :ensure t
  :config
  (setq web-mode-markup-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-enable-auto-closing t
	web-mode-enable-engine-detection t
	web-mode-enable-current-element-highlight t)

  ;; (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
  ;; (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tmpl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode)))

(use-package rjsx-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '(".*\.jsx?\'" . rjsx-mode))
  (add-hook 'rjsx-mode-hook
	    (lambda ()
	      (setq indent-tabs-mode nil) ;;Use space instead of tab
	      (setq js-indent-level 2) ;;space width is 2 (default is 4)
	      (setq js2-strict-missing-semi-warning nil))) ;;disable the semicolon warning)
  (add-hook 'web-mode-hook 'jsx-flycheck))

(use-package typescript-mode
  :ensure t)

(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(defun jsx-flycheck ()
  (when (equal web-mode-content-type "jsx")
    ;; enable flycheck
    (flycheck-select-checker 'jsxhint-checker)
    (flycheck-mode)))

(use-package easy-hugo
  :ensure t
  :config
  (setq easy-hugo-markdown-extension "markdown"
	easy-hugo-previewtime "300"))

(provide 'web-lang)

;;; web-lang.el ends here
