;;; github-clone-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (eshell/github-clone github-clone) "github-clone"
;;;;;;  "github-clone.el" (21546 40331 774613 24000))
;;; Generated autoloads from github-clone.el

(autoload 'github-clone "github-clone" "\
Fork and clone USER-REPO-URL into DIRECTORY.

USER-REPO-URL can be any of the forms:

  repository
  user/repository
  organization/repository
  https://github.com/user/repository
  git@github.com:user/repository.git
  https://github.com/user/repository.el.git

If repository is already owned by user, it will simply clone the
repository to DIRECTORY, otherwise it will attempt to fork the
repository to user and clone the fork to DIRECTORY.

If DIRECTORY does not exist, it will be created, otherwise it
expands the repository name in the specified directory.

If repository is a fork then the upstream remote will be added
automatically.

\(fn USER-REPO-URL DIRECTORY)" t nil)

(autoload 'eshell/github-clone "github-clone" "\
Eshell alias uses current directory as default.

\(fn USER-REPO-URL &optional DIRECTORY)" nil nil)

;;;***

;;;### (autoloads nil nil ("github-clone-pkg.el") (21546 40331 791549
;;;;;;  168000))

;;;***

(provide 'github-clone-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; github-clone-autoloads.el ends here
