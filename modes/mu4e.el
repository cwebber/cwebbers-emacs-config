(setq mu4e-maildir       "~/Maildir"   ;; top-level Maildir
      mu4e-sent-folder   "/sent-to-misc"       ;; where do i keep sent mail?
      mu4e-drafts-folder "/drafts")     ;; where do i keep half-written mail?
      ; mu4e-trash-folder  "/trash")     ;; where do i move deleted mail?
(add-to-list 'load-path "~/programs/mu/mu4e/")
(setq mu4e-mu-binary "/home/cwebber/programs/mu/mu/mu")

(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-html2text-command "html2text -utf8 -width 72")

(require 'mu4e)
(require 'org-mu4e)

(setq mu4e-maildir-shortcuts
      '(("/Inbox.General"     . ?i)
        ("/CC Staff"   . ?c)
        ("/Spam"       . ?s)
        ("/sent-to-misc" . ?S)))

(setq smtpmail-queue-mail  nil  ;; start in non-queuing mode
      smtpmail-queue-dir   "~/Maildir/queue/cur")

(setq mu4e-bookmarks
  '(("flag:unread AND NOT flag:trashed AND NOT maildir:/Spam" "Unread messages"      ?u)
    ("date:today..now AND NOT maildir:/Spam"                  "Today's messages"     ?t)
    ("date:7d..now AND NOT maildir:/Spam"                     "Last 7 days"          ?w)
    ("mime:image/* AND NOT maildir:/Spam"                     "Messages with images" ?p)
    ("flag:unread AND NOT flag:trashed AND maildir:/Spam"     "Unread spam"          ?s)
    ("flag:unread AND maildir:/Inbox.General"  "Unread general inbox" ?i)))

(load-file "~/devel/mu4e-uqueue/mu4e-uqueue.el")
(load-file "~/devel/mu4e-uqueue/uqueue-advice.el")
