(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Refresh package list and install any missing packages
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;;add lisp directory to load path; put .el files there
(add-to-list 'load-path (expand-file-name "lisp/" user-emacs-directory))
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

;;ido mode
(ido-mode t)

;; Smex gives M-x ido-like behavior
(require 'smex)
(smex-initialize)

;; Smartparens
(require 'smartparens-config)
(sp-use-paredit-bindings)
(add-hook 'prog-mode-hook #'smartparens-strict-mode)
(add-hook 'cider-mode-hook 'smartparens-strict-mode 'cider-turn-on-eldoc-mode)

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


(require 'keybindings)
