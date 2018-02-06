
;; Smex keybindings
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; Bind old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Add date insert helper to beancount mode
(define-key beancount-mode-map (kbd "C-c t") 'insert-today-date)
;; Import CSV file into beancount
(define-key beancount-mode-map (kbd "C-c i") 'import-beancount)

;;Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; A global toggle map
;; from http://endlessparentheses.com/the-toggle-map-and-wizardry.html
(define-prefix-command 'endless/toggle-map)
;; The manual recommends C-c for user keys, but C-x t is
;; always free, whereas C-c t is used by some modes.
(define-key ctl-x-map "t" 'endless/toggle-map)
(define-key endless/toggle-map "c" #'column-number-mode)
(define-key endless/toggle-map "d" #'toggle-debug-on-error)
(define-key endless/toggle-map "e" #'toggle-debug-on-error)
(define-key endless/toggle-map "f" #'auto-fill-mode)
(define-key endless/toggle-map "l" #'toggle-truncate-lines)
(define-key endless/toggle-map "q" #'toggle-debug-on-quit)
(define-key endless/toggle-map "t" #'endless/toggle-theme)
;;; Generalized version of `read-only-mode'.
(define-key endless/toggle-map "r" #'dired-toggle-read-only)
(autoload 'dired-toggle-read-only "dired" nil t)
(define-key endless/toggle-map "w" #'whitespace-mode)
(define-key endless/toggle-map "n" #'narrow-or-widen-dwim)

;; A global launch map to launch semi-frequent things
;; http://endlessparentheses.com/launcher-keymap-for-standalone-features.html
(define-prefix-command 'launcher-map)
;; `C-x l' is `count-lines-page' by default. If you
;; use that, you can try s-l or <C-return>.
(define-key ctl-x-map "l" 'launcher-map)
(global-set-key (kbd "s-l") 'launcher-map)
(define-key launcher-map "p" #'paradox-list-packages)
(define-key launcher-map "c" #'calc)
(define-key launcher-map "d" #'ediff-buffers)
(define-key launcher-map "f" #'find-dired)
(define-key launcher-map "g" #'lgrep)
(define-key launcher-map "G" #'rgrep)
(define-key launcher-map "h" #'man) ; Help
(define-key launcher-map "i" #'package-install-from-buffer)
(define-key launcher-map "n" #'endless/visit-notifications)
(define-key launcher-map "s" #'shell)


(provide 'keybindings)
