;;; package --- Main init file
;;; Commentary:
;;; This is my init file

;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory)
         user-emacs-directory)
        ((boundp 'user-init-directory)
         user-init-directory)
        (t "~/.emacs.d/")))


(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

(load-user-file "packages.el")
(load-user-file "functions.el")
(load-user-file "emacs.el")
(load-user-file "python.el")
(load-user-file "go.el")
(load-user-file "web.el")
(load-user-file "shell.el")
(load-user-file "keys.el")
(load-user-file "org.el")
(load-user-file "powerline.el")

(provide 'init)
