;;; github-clone.el --- Fork and clone github repos  -*- lexical-binding: t; -*-

;; Copyright (C) 2014  Charles L.G. Comstock

;; Author: Charles L.G. Comstock <dgtized@gmail.com>
;; Created: 2 Aug 2014
;; Version: 20140830.1935
;; X-Original-Version: 0.1
;; URL: https://github.com/dgtized/github-clone.el
;; Keywords: vc, tools
;; Package-Requires: ((gh "0.7.2") (magit "1.2.0") (emacs "24"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; `github-clone' will automatically fork a repo to the user, clone it locally to
;; a specified directory, and add a remote named upstream if repository is a
;; fork.

;;; Todo:

;; Use `github-clone-remotes' to add named remotes easily for repositories in
;; the same network.

;;; Code:

(require 'eieio)
(require 'gh-users)
(require 'gh-repos)
(require 'magit)

(defcustom github-clone-remote-name "upstream"
  "Default name for upstream remote"
  :type '(radio (const :tag "Disabled" nil)
                (string :tag "Name"))
  :group 'github-clone)

(defcustom github-clone-url-slot :ssh-url
  "Which slot to use as the URL to clone."
  :type '(radio (const :tag "SSH" :ssh-url)
                (const :tag "HTTPS" :clone-url)
                (const :tag "Git" :git-url))
  :group 'github-clone)

(defun github-clone-fork (repo)
  (oref (gh-repos-fork (gh-repos-api "api") repo) :data))

(defun github-clone-info (user repo-id)
  (oref (gh-repos-repo-get (gh-repos-api "api") repo-id user) :data))

(defun github-clone-remotes (user repo-id)
  (let* ((repo (github-clone-info user repo-id))
         (forks (oref (gh-repos-forks-list (gh-repos-api "api") repo) :data)))
    (cl-loop for fork in forks
             collect (cons (oref (oref fork :owner) :login)
                           (eieio-oref fork github-clone-url-slot)))))

(defun github-clone-upstream (repo)
  (if (and (eq (oref repo :fork) t) github-clone-remote-name)
      (cons github-clone-remote-name
            (eieio-oref (oref repo :parent) github-clone-url-slot))
    nil))

(defun github-clone-repo (repo directory)
  (let* ((name (oref repo :name))
         (target (if (file-exists-p directory)
                     (expand-file-name name directory)
                   directory))
         (repo-url (eieio-oref repo github-clone-url-slot)))
    (message "Cloning %s into %s from \"%s\"" name target repo-url)
    (if (not (= 0 (shell-command (format "git clone %s %s" repo-url target)
                                 "*github-clone output*")))
        (error "Failed to clone repo \"%\" to directory \"%s\"" repo-url target))
    (magit-status target)
    (let ((upstream (github-clone-upstream repo)))
      (when upstream
        (message "Adding remote %s" upstream)
        (magit-add-remote (car upstream) (cdr upstream))))))

(defun github-clone-repo-name (url)
  (cond ((string-match "\.git$" url)
         (github-clone-repo-name (replace-match "" nil nil url)))
        ((string-match "\\([[:alnum:]\-_.]+\\)/\\([[:alnum:]\-_.]+\\)$" url)
         (cons (match-string 1 url) (match-string 2 url)))
        ((string-match "^\\([[:alnum:]\-_.]+\\)$" url)
         (cons (github-clone-user-name) (match-string 1 url)))
        (t (error "Cannot parse repo name %s" url))))

(defvar github-clone--user nil "Cache for current github login.")
(defun github-clone-user-name ()
  (unless github-clone--user
    (setq github-clone--user
          (oref (oref (gh-users-get (gh-users-api "api")) :data) :login)))
  github-clone--user)

;;;###autoload
(defun github-clone (user-repo-url directory)
  "Fork and clone USER-REPO-URL into DIRECTORY.

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
automatically."
  (interactive
   (list (read-from-minibuffer "Url or User/Repo: ")
         (read-directory-name "Directory: " nil default-directory t)))
  (let* ((name (github-clone-repo-name user-repo-url))
         (repo (github-clone-info (car name) (cdr name))))
    (if (eieio-oref repo github-clone-url-slot)
        (let ((fork (github-clone-fork repo)))
          (if (eieio-oref fork github-clone-url-slot)
              (github-clone-repo fork directory)
            (error "Unable to fork %s" user-repo-url)))
      (error "Repository %s does not exist" user-repo-url))))

;;;###autoload
(defun eshell/github-clone (user-repo-url &optional directory)
  "Eshell alias uses current directory as default."
  (funcall 'github-clone user-repo-url (or directory default-directory)))

(provide 'github-clone)
;;; github-clone.el ends here
