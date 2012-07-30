(setq mu4e-maildir       "~/Maildir"   ;; top-level Maildir
      mu4e-sent-folder   "/sent-to-misc"       ;; where do i keep sent mail?
      mu4e-drafts-folder "/drafts")     ;; where do i keep half-written mail?
      ; mu4e-trash-folder  "/trash")     ;; where do i move deleted mail?
(add-to-list 'load-path "~/programs/maildir-utils/emacs/")
(setq mu4e-mu-binary "/home/cwebber/programs/maildir-utils/mu/mu")
(require 'mu4e)
