;;; functions.el --- Avelino functions for Emacs

;;; Commentary:
;;
;;; Code:

(require 'cl-lib)
(require 'thingatpt)

(use-package counsel)
(use-package swiper)

;; Delete words
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

;; COPY / PASTE on OSX
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(when (memq window-system '(mac ns))
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(defun bookmark-jump-or-find-file (bookmark)
  "Jump to BOOKMARK, but if it's a directory, start a 'find-file' from there."
  (interactive
   (list (bookmark-completing-read "Jump to bookmark")))
  (if (file-directory-p (bookmark-get-filename bookmark))
      (let ((default-directory (bookmark-get-filename bookmark)))
        (counsel-find-file))
    (bookmark-jump bookmark)))

(defun beginning-of-buffer-record ()
  "Record the current position in buffer and move to beginning."
  (point-to-register 9)
  (beginning-of-buffer))

(defun end-of-buffer-record ()
  "Record the current position in buffer and move to end."
  (point-to-register 9)
  (end-of-buffer))

(defun go-back-to-point ()
  "Go back to the point before navigating to beginning or end of buffer."
  (interactive)
  (jump-to-register 9))

(defun split-window-below-and-switch ()
  "Split the window horizontally, then switch to the new pane."
  (interactive)
  (split-window-below)
  (other-window 1))

(defun split-window-right-and-switch ()
  "Split the window vertically, then switch to the new pane."
  (interactive)
  (split-window-right)
  (other-window 1))

(defun disable-neotree-hook (_unused)
  (linum-mode -1))

(defun iterm-focus ()
  (interactive)
  (do-applescript
   " do shell script \"open -a iTerm\"\n"
   ))

(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))

(defun codenav-get-candidates ()
  "Fetch list of sorted imenu candidates."
  (let* ((items (counsel-imenu-get-candidates-from (imenu--make-index-alist)))
	 (items (delete (assoc "*Rescan*" items) items)))
    items))

(defun codenav-current-symbol (names-and-pos)
  "Figure out current definition by checking positions of NAMES-AND-POS against current position."
  (interactive)
  (let ((current-index 0))
    (dolist (symbol names-and-pos)
      (let* ((current-line (point))
	     (current-symbol-pos (marker-position (cdr (cdr symbol))))
	     ;; If we reaches the end, just return the last element
	     ;; instead of returning index+1
	     (selected-index (if (< (1+ current-index) (length names-and-pos))
				 (1+ current-index)
			       current-index))
	     (next-symbol-pos
	      (marker-position (cdr (cdr (nth selected-index names-and-pos))))))
	(if (and (>= current-line current-symbol-pos) (< current-line next-symbol-pos))
	    (return current-index)))
      (setq current-index (1+ current-index)))
    ;; If last item, decrement index
    (if (eq current-index (length names-and-pos))
	(1- current-index)
      current-index)))


(defun codenav-next-definition ()
  "Navigate to next function/class definition."
  (interactive)
  (let* ((names-and-pos (codenav-get-candidates))
	 (current-symbol (codenav-current-symbol names-and-pos))
	 (next-symbol (cdr (nth (1+ current-symbol) names-and-pos))))
    (imenu next-symbol)))


(defun codenav-prev-definition ()
  "Navigate to previous function/class definition."
  (interactive)
  (let* ((names-and-pos (codenav-get-candidates))
	 (current-symbol (codenav-current-symbol names-and-pos))
	 (prev-symbol (cdr (nth (1- current-symbol) names-and-pos))))
    (imenu prev-symbol)))

(provide 'functions)

;;; functions.el ends here
