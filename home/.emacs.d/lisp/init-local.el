;;; package --- Initiliaze local stuff

;;; Load theme first!
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'monokai t)

;;; Load emacs-eclim on startup
(require 'init-eclim)

;;; Load multiple-cursors
(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Load mu4e
(require 'init-mu4e)

;; Pretty print xml
(load "~/.emacs.d/custom/pretty_print_xml.el")

;;Auto-complete
(add-to-list 'load-path "~/.emacs.d/lisp/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/auto-complete/ac-dict")
(ac-config-default)

;;Answer 'y' insetead of 'yes'
(fset 'yes-or-no-p 'y-or-n-p)

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle\\'" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(setq auto-mode-alist
      (cons (cons "\\.pl" 'prolog-mode)
	    auto-mode-alist))


(global-hl-line-mode 0)
(set-face-background 'highlight "#222")
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight nil)

(global-linum-mode t)
(add-hook 'text-mode-hook 'visual-line-mode)
(setq global-font-lock-mode 1)

;; Auto indent
(global-set-key (kbd "RET") 'newline-and-indent)

;; Always show column numbers.
(setq-default column-number-mode t)

;; Display full pathname for files.
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

;; For easier regex search/replace.
(defalias 'qrr 'query-replace-regexp)


;;; Rainbow delimiters
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook '(lambda ()))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "forest green"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange red"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "purple"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "medium blue"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "magenta")))))

;;; 64bit assembler mode
(load "~/.emacs.d/elpa/nasm-mode.el")
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.\\(asm\\|s\\)$" . nasm-mode))

;;; ace-jump-mode
(require 'init-ace-jump)

;;; iy-go-to-char
(require 'iy-go-to-char)
(define-key global-map (kbd "M-ö") 'iy-go-to-char)

(provide 'init-local)
;;; init-local.el ends here

