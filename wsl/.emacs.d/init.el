;; -*- coding: utf-8; lexical-binding: t -*-
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1)
  (menu-bar-mode -1)
)

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

(when (and (eq system-type 'gnu/linux) (getenv "WSLENV"))
  ;; WSL-specific setup
  (add-to-list 'default-frame-alist '(foreground-color . "grey90"))
  (add-to-list 'default-frame-alist '(background-color . "grey10"))
  (setq frame-resize-pixelwise t) ; Sometimes helps with border issues [3]
)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("ublt" . "https://elpa.ubolonton.org/packages/") t)

(setq package-native-compile t)

(setq custom-safe-themes t)

(setq use-package-always-ensure t)

(unless (package-installed-p 'use-package)
  (message "refreshing contents")
  (unless package-archive-contents (package-refresh-contents))
  (package-install 'use-package))

;;; Use ./lisp/ dir for custom config
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(eval-when-compile
  (require 'use-package)
  (require 'ob-tangle))

(require 'init-local)

(setq max-lisp-eval-depth 2000)

;(reload-config)
(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3613617b9953c22fe46ef2b593a2e5bc79ef3cc88770602e7e569bbd71de113b" "f1e8339b04aef8f145dd4782d03499d9d716fdc0361319411ac2efc603249326" default))
 '(package-selected-packages '(doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
