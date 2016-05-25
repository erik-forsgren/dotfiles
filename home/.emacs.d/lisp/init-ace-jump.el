;;; package --- init-ace-jump
;;; Commentary:

;;; Code:

;;; Jump to words with ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-ö") 'ace-jump-mode)

(eval-after-load "ace-jump-mode"
  '(progn
     (defadvice ace-jump-char-category (around adv-ace-jump-support-umlauts activate)
       (unless (= (char-syntax (ad-get-arg 0)) ?w)
	 ad-do-it)
       (setq ad-return-value 'alpha))))

(provide 'init-ace-jump)
;;; init-ace-jump.el ends here
