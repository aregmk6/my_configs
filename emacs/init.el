(setq inhibit-startup-message t)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(setq display-warning-minimum-level :error)

;; =====

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(when (< emacs-major-version 29)
  (unless (package-installed-p 'use-package)
    (unless package-archive-contents
      (package-refresh-contents))
    (package-install 'use-package)))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))
(put 'narrow-to-region 'disabled nil)

;; built-in packages configuration

(use-package dired
  :ensure nil
  :bind (("C-x d" . dired)
	 ("C-c d" . dired-jump)))
