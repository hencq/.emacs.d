(defun import-beancount ()
  "docstring"
  (interactive)
  (let ((file (ido-read-file-name "File to import: ")))
    (with-output-to-temp-buffer "*import*"
      (shell-command (concat "./import.py " file) "*import*"))
    (pop-to-buffer "*import*")))

;; Helper to insert today's date into beancount
(defun insert-today-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(provide 'beancount-helpers)



