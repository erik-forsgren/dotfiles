(require 'mu4e)
(setq mu4e-debug t)
(setq mu4e-mu-binary "/usr/bin/mu")
(setq mu4e-maildir "~/Maildir") ;; top-level Maildir
(setq mu4e-sent-folder "/Utkorg") ;; where do i keep sent mail?

(setq
   mu4e-get-mail-command "offlineimap"   ;; or fetchmail, or ...
   mu4e-update-interval 600)             ;; update every 5 minutes

(setq mu4e-drafts-folder "/Utkast")
(setq mu4e-user-mail-address-list (list "erik.forsgren@r2m.se"))
;;  (setq user-mail-address-list "erik.forsgren@r2m.se")
(setq message-kill-buffer-on-exit t)

;; Shortcuts
(setq mu4e-maildir-shortcuts
      '(("/INBOX" . ?i)
        ))

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)


;; Try to display images in mu4e
(setq
 mu4e-view-show-images t
 mu4e-view-image-max-width 800)

;; use 'fancy' non-ascii characters in various places in mu4e
;;(setq mu4e-use-fancy-chars t)

;; save attachment to my Downloads (this can also be a function)
(setq mu4e-attachment-dir "~/Downloads")

;; sending mail
(setq message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "/usr/bin/msmtp"
      user-full-name "Erik Forsgren")
(setq smtpmail-smtp-server "smtp.office365.com")


(setq mu4e-confirm-quit nil)

(setq  mu4e-headers-date-format "%Y-%m-%d %H:%M") ; date format

(setq mu4e-headers-fields
      '( (:date          .  20)	;; alternatively, use :human-date
         (:flags         .   6)
         (:from          .  22)
         (:subject       .  nil))) ;; alternatively, use :thread-subject

(setq mu4e-html2text-command "w3m -T text/html")

;; Borrowed from http://ionrock.org/emacs-email-and-mu.html
;; Choose account label to feed msmtp -a option based on From header
;; in Message buffer; This function must be added to
;; message-send-mail-hook for on-the-fly change of From address before
;; sending message since message-send-mail-hook is processed right
;; before sending message.
(defun choose-msmtp-account ()
  (if (message-mail-p)
      (save-excursion
        (let*
            ((from (save-restriction
                     (message-narrow-to-headers)
                     (message-fetch-field "from")))
             (account "office365"))
          (setq message-sendmail-extra-arguments (list '"-a" account))))))

(setq message-sendmail-envelope-from 'header)

(add-hook 'message-send-mail-hook 'choose-msmtp-account)

(add-hook 'mu4e-compose-pre-hook
          (defun my-set-from-address ()
            "Set the From address based on the To address of the original."
            (let ((msg mu4e-compose-parent-message)) ;; msg is shorter...
              (if msg
                  (setq user-mail-address
                        (cond
                         ((mu4e-message-contact-field-matches msg :to "erik.forsgren@r2m.se")
                          "erik.forsgren@r2m.se")
                         (t "erik.forsgren@r2m.se")))))))
(provide 'init-mu4e)
