(defun import-beancount (file &optional name)
  "docstring"
  (interactive
   (if (equal current-prefix-arg '(4))
     (list
      (ido-read-file-name "File to import: ")
      (read-string "Parser name: "))
     (list
      (ido-read-file-name "File to import: "))))
  (with-output-to-temp-buffer "*import*"
    (shell-command (concat "./import.py '" file "'"
                           (when name (concat " -n " name))) "*import*"))
  (pop-to-buffer "*import*"))

;; Helper to insert today's date into beancount
(defun insert-today-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))

(provide 'beancount-helpers)



