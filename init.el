; General settings
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )

(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-12"))

; use-package
(require 'package)
(setq package-enable-at-startup nil) ; tells emacs not to load any packages before starting up
(setq package-archives '(("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Use use-package to configure packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(use-package general :ensure t
  :after which-key
  :config (general-override-mode t))
(use-package which-key :ensure t
  :config (which-key-mode t))
(use-package ivy :ensure t)
(use-package counsel :ensure t
  :after ivy)
(use-package swiper :ensure t
  :after ivy)
(use-package evil :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection :ensure t
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(general-define-key ;;replace some default bindings
 "M-x" 'counsel-M-x)

(general-define-key
 :states '(normal visual)
 "," (general-simulate-key "SPC m"))

(general-create-definer space-def
  :states '(normal visual insert motion emacs)
  :prefix "SPC"
  :non-normal-prefix "C-SPC")

(space-def
  "" nil
  "c" (general-simulate-key "C-c")
  "h" (general-simulate-key "C-h")
  "u" (general-simulate-key "C-u")
  "x" (general-simulate-key "C-x")
  "SPC" 'counsel-M-x

  ;; Package manager
  "lp" 'list-packages

  ;; Quitting
  "q" '(:ignore t :which-key "quit emacs")
  "qq" 'kill-emacs
  "qz" 'delete-frame

  ;; Buffer ops
  "b" '(:ignore t :which-key "buffer")
  "bb" 'ivy-switch-buffer
  "TAB" '(mode-line-other-buffer :which-key "prev buffer")
  "bd" 'kill-this-buffer
  "b]" 'next-buffer
  "b[" 'previous-buffer
  "bq" 'kill-buffer-and-window
  "bR" 'rename-file-and-buffer
  "br" 'revert-buffer

  ;; Window ops
  "w" '(:ignore t :which-key "window")
  "wm" 'maximize-window
  "w/" 'split-window-horizontally
  "wv" 'split-window-vertically
  "wm" 'maximize-window
  "wu" 'winner-undo
  "ww" 'other-window
  "wd" 'delete-window
  "wD" 'delete-other-windows

  ;; File ops
  "f" '(:ignore t :which-key "files")
  "ff" 'counsel-find-file
  "fc" 'write-file
  "fe" '(:ignore t :which-key "emacs")
  "fed" 'find-user-init-file
  "feR" 'load-user-init-file
  "fj" 'dired-jump
  "fl" 'find-file-literally
  "fR" 'rename-file-and-buffer
  "fs" 'save-buffer

  ;; Applications
  "a" '(:ignore t :which-key "Applications")
  "ad" 'dired
  ":" 'shell-command
  ";" 'eval-expression
  "oa" 'org-agenda
  "ac" 'calc

  ;;Magit
  "g" '(:ignore t :which-key "Magit")
  "gs" 'magit-status)

(space-def
  :keymaps '(emacs-lisp-mode-map lisp-mode-map lisp-interaction-mode-map)
  "m" '(:ignore t :which-key "Lisp mode")
  "me" '(:ignore t :which-key "Eval")
  "mee" 'eval-last-sexp
  "meb" 'eval-buffer
  "mef" 'eval-defun
  "mer" 'eval-region)

(space-def
  :keymaps 'racket-mode-map
  "m" '(:ignore t :which-key "Racket mode")
  "me" '(:ignore t :which-key "Eval")
  "mee" 'racket-send-last-sexp
  "meb" 'racket-run
  "mef" 'racket-send-definition
  "mer" 'racket-send-region
  "mem" 'racket-run-module-at-point)

(use-package evil-magit :ensure t)
;;add lisp directory to load path; put .el files there
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
;; (add-to-list 'load-path (expand-file-name "lisp/racket-mode" user-emacs-directory))
(add-to-list 'load-path "/usr/local/elisp/")

;; Add $PATH to exec path
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'better-defaults)

;;enable the menu bar
(menu-bar-mode 1)

;; Set up appearence
(add-hook 'prog-mode-hook 'linum-mode)
(column-number-mode 1)
(load-theme 'zenburn)
(use-package spaceline :ensure t
  :config (spaceline-spacemacs-theme))

;; commented out ido and smex to give ivy a try
;;ido mode
;;(ido-mode t)

;; smex gives m-x ido-like behavior
;(require 'smex)
;(smex-initialize)

;; smartparens
(use-package smartparens :ensure t
  :hook (prog-mode . smartparens-strict-mode)
  :config (require 'smartparens-config))
  
(use-package evil-cleverparens :ensure t
  :after smartparens
  :hook (smartparens-strict-mode . evil-cleverparens-mode))
;(require 'smartparens-config)
;(sp-use-paredit-bindings)
;(add-hook 'prog-mode-hook #'smartparens-strict-mode)
;(add-hook 'cider-mode-hook 'smartparens-strict-mode 'cider-turn-on-eldoc-mode)

;; Show matching parens
(show-paren-mode 1)

;; Iedit for fast replacing
(require 'iedit)

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Narrow and widen based on context
(require 'narrow-or-widen)

;; Use Clojure mode for .cljs files
(setq auto-mode-alist (cons '("\\.cljs" . clojure-mode) auto-mode-alist))

;; Enable repl for figwheel using inf-clojure
(defun figwheel-repl ()
  (interactive)
  (run-clojure "lein figwheel"))

(add-hook 'clojure-mode-hook #'inf-clojure-minor-mode)

(setenv "PATH" (concat (getenv "PATH") ":/Users/hencq/.lein/bin"))
(setq exec-path (append exec-path '("/Users/hencq/.lein/bin")))

;;set go mode
(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 2 indent-tabs-mode 1))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin:/Users/hencq/code/go/bin"))
(setq exec-path (append exec-path '("/usr/local/go/bin" "/Users/hencq/code/go/bin")))
(setenv "GOPATH" "/Users/hencq/code/go")

;;go autocomplete mode
(require 'go-autocomplete)
(require 'auto-complete-config)
(add-to-list 'ac-modes 'go-mode)
(global-auto-complete-mode t)

;;Octave
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

;;Beancount
(require 'beancount)
(require 'beancount-helpers)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

;;Racket
(require 'company)
(require 'racket-mode)
(add-hook 'racket-mode-hook 'company-mode)
(add-hook 'racket-mode-hook (lambda ()
                              ;; (set (make-local-variable 'eldoc-documentation-function)
                              ;;      'racket-eldoc-function)
                              (setq prettify-symbols-alist (cons '("lambda" . ?λ) prettify-symbols-alist))
                              (prettify-symbols-mode 1)
                              (set (make-local-variable 'company-backends)
                                   '((company-capf company-dabbrev-code)))))

(setq org-babel-python-command "python3")
(require 'ob-dot)

;;Javascript/HTML
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
(add-hook 'web-mode-hook
  (lambda ()
    (if (equal web-mode-content-type "javascript")
      (web-mode-set-content-type "jsx")
      (message "now set to: %s" web-mode-content-type))
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)))

;;Org mode
(use-package org :ensure t
  :mode (("\\.org$" . org-mode))
  :config
  (setq org-directory "/Users/keesjochem/Google Drive File Stream/My Drive/org")
  (setq org-default-notes-file (concat org-directory "/todo.org"))
  (require 'org-tempo))

;;Multiple cursors
(require 'multiple-cursors)

;;Emmet provides snippets for html+css
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(require 'keybindings)
