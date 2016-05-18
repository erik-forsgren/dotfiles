;;; package --- init-eclim
;;; Commentary:
(require 'eclim)
(require 'eclimd)
(global-eclim-mode)

(setq eclim-auto-save t) ;; You *need* to have this one
(setq eclim-executable "/usr/lib/eclipse/eclim") ;; Where the eclim installation is in
(setq eclimd-default-workspace "~/work/inera/code") ;; Eclipse workspace

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

;; So emacs won't freeze waiting for eclimd to start
(setq eclimd-wait-for-process nil)

;; auto complete
(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)

;; Hook eclim up with auto complete mode
(require 'auto-complete-config)
(ac-config-default)
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)


(provide 'init-eclim)
;;; init-eclim ends here
