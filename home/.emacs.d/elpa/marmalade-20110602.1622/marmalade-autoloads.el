;;; marmalade-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (marmalade-upload-buffer marmalade-register marmalade-login)
;;;;;;  "marmalade" "marmalade.el" (21546 40519 685712 105000))
;;; Generated autoloads from marmalade.el

(autoload 'marmalade-login "marmalade" "\
Log in to Marmalade and get the username and authentication token.
Prompt interactively for the user's username and password, then
use these to retreive the token.

CALLBACK is called when the login is completed, and passed the
username and the authentication token.

\(fn &optional CALLBACK)" t nil)

(autoload 'marmalade-register "marmalade" "\
Register a user with NAME, EMAIL, and PASSWORD.
The authentication token is passed to CALLBACK.

\(fn NAME EMAIL PASSWORD &optional CALLBACK)" t nil)

(autoload 'marmalade-upload-buffer "marmalade" "\
Upload the package in BUFFER.
BUFFER should be visiting an Elisp file or a tarball.

CALLBACK is called with the package object once the package is
uploaded.

\(fn BUFFER &optional CALLBACK)" t nil)

;;;***

;;;### (autoloads nil nil ("marmalade-pkg.el") (21546 40519 700770
;;;;;;  353000))

;;;***

(provide 'marmalade-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; marmalade-autoloads.el ends here
