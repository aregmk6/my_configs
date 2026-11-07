;; -*- lexical-binding: t; -*-

;; general setup ========================================================================

(setq inhibit-startup-message 1)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)
(delete-selection-mode 1)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(setq display-line-numbers-type 'relative)

(setq display-warning-minimum-level :error)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(setq scroll-preserve-screen-position t)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; my scripts ========================================================================

(defun my-copy-entire-line ()
  "Copy entire line you're currently on"
  (interactive)
  (kill-ring-save (line-beginning-position) (line-end-position)))
(global-set-key (kbd "C-c C-l") 'my-copy-entire-line)

(defun my-copy-from-indent-line ()
  "Copy line from after the indentation to the end on the line you're currently on"
  (interactive)
  (let ((startpos (save-excursion
    (back-to-indentation)
    (point))))
    (kill-ring-save startpos (line-end-position))))
(global-set-key (kbd "C-c l") 'my-copy-from-indent-line)

(global-set-key (kbd "C-S-v") #'scroll-up-command)
(global-set-key (kbd "M-S-v") #'scroll-down-command)

(defun my-scroll-halfpage-up ()
  "Scroll half a page up"
  (interactive)
  (scroll-up (/ (window-body-height) 2)))
(global-set-key (kbd "C-v") #'my-scroll-halfpage-up)

(defun my-scroll-halfpage-down ()
  "Scroll half a page-down"
  (interactive)
  (scroll-down (/ (window-body-height) 2)))
(global-set-key (kbd "M-v") #'my-scroll-halfpage-down)

;; global modes ========================================================================

(global-display-line-numbers-mode 1)
(global-hl-line-mode 1)

;; modes setup ========

(add-to-list 'load-path "/home/aregmk/.emacs.d/mymodes/")
(require 'odin-mode)
(add-to-list 'auto-mode-alist '("\\.odin\\'" . odin-mode))

(use-package go-mode
  :ensure t)

;; package setup ========

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

;; packages =========

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))
(put 'narrow-to-region 'disabled nil)

(use-package vertico
  :ensure t
  :hook (after-init . vertico-mode))

(use-package marginalia
  :ensure t
  :hook (after-init . marginalia-mode))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic))
  (setq completion-category-defaults nil)
  (setq completion-category-overrides nil))

(use-package corfu
  :ensure t
  :hook (after-init . global-corfu-mode)
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package dired-subtree
  :ensure t
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-M->"       . mc/skip-to-next-like-this)
         ("C-M-<"       . mc/skip-to-previous-like-this)))

(use-package avy
  :ensure t
  :bind ("C-:" . 'avy-goto-char))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package websocket
  :ensure t
  :defer t)
(use-package typst-preview
  :ensure t)
(setq typst-preview-invert-colors "never")

(use-package typst-ts-mode
  :vc (:url "https://codeberg.org/meow_king/typst-ts-mode.git")
  :ensure t)

(use-package markdown-ts-mode
  :ensure nil
  :mode ("\\.md\\'" "\\.mdx\\'" "\\.markdown\\'")
  :config
  (require 'markdown-ts-mode-x))

(use-package grip-mode
  :ensure t
  :custom (grip-command 'auto) ;; auto, grip, go-grip or mdopen
  :config (setq grip-binary-path "/home/aregmk/.local/bin/grip"))

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'markdown-mode-hook #'yas-minor-mode))
(use-package yasnippet-snippets
  :ensure t)
(setq yas-prompt-functions '(yas-ido-prompt))

(use-package dumb-jump
  :ensure t
  :custom
  (dumb-jump-prefer-searcher 'rg)
  :config
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))

;; org mode related packages ==========================================

(use-package ox-typst
  :after org
  :ensure t)

;; built-in packages configuration ============================================

(use-package savehist
  :ensure nil
  :hook (after-init . savehist-mode))

;; Email setup ========================================
;; .authinfo file has the password and shiz

(setq user-mail-address "aregmkhitaryan@gmail.com")

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 465
      smtpmail-stream-type 'ssl)

;; general path setup ================================

(add-to-list 'exec-path "/home/aregmk/.local/bin/")
(setenv "PATH" (concat "/home/aregmk/.local/bin/:" (getenv "PATH")))

(add-to-list 'exec-path "/home/aregmk/go/bin/")
(setenv "PATH" (concat "/home/aregmk/go/bin/:" (getenv "PATH")))
