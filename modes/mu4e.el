(setq mu4e-maildir       "~/Maildir"   ;; top-level Maildir
      mu4e-sent-folder   "/sent-to-misc"       ;; where do i keep sent mail?
      mu4e-drafts-folder "/drafts")     ;; where do i keep half-written mail?
      ; mu4e-trash-folder  "/trash")     ;; where do i move deleted mail?
(add-to-list 'load-path "~/programs/mu/mu4e/")
(setq mu4e-mu-binary "/home/cwebber/programs/mu/mu/mu")

(setq mu4e-get-mail-command "offlineimap")

(require 'mu4e)
(require 'org-mu4e)
