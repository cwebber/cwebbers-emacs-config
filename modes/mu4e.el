(setq mu4e-maildir       "~/Maildir"   ;; top-level Maildir
      mu4e-sent-folder   "/sent-to-misc"       ;; where do i keep sent mail?
      mu4e-drafts-folder "/drafts")     ;; where do i keep half-written mail?
      ; mu4e-trash-folder  "/trash")     ;; where do i move deleted mail?

;; <mark_weaver> paroneayea: it's a hack, but /run/current-system will exist on a
;;               GuixSD system and not on Debian.
;; <mark_weaver> I hope such a test will never end up in any published software.
(if (file-exists-p "/run/current-system")
    (add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp/mu4e/"))
; (setq mu4e-mu-binary "/home/cwebber/programs/mu/mu/mu")

(require 'mu4e)
(require 'org-mu4e)
(require 'mu4e-contrib)

; (setq mu4e-msg2pdf "/usr/bin/msg2pdf")
(setq mu4e-msg2pdf "/home/cwebber/programs/mu/toys/msg2pdf/msg2pdf")

(setq mu4e-get-mail-command "fdm fetch -v")
(setq mu4e-html2text-command 'mu4e-shr2text)
;; (setq mu4e-html2text-command "html2text -utf8 -width 72")
;;;; When all goes badly:
;; (setq mu4e-html2text-command "cat")

(setq mu4e-maildir-shortcuts
      '(("/Inbox.General"     . ?i)
        ("/CC Staff"   . ?c)
        ("/Spam"       . ?s)
        ("/sent-to-misc" . ?S)))

(setq smtpmail-queue-mail  nil  ;; start in non-queuing mode
      smtpmail-queue-dir   "~/Maildir/queue/cur")

(setq mu4e-bookmarks
  '(("flag:unread AND NOT flag:trashed AND NOT maildir:/Spam" "Unread messages"      ?u)
    ("flag:unread AND NOT flag:trashed AND NOT maildir:/Spam AND NOT (/Inbox.General OR /Mediagoblin OR \"/W3C Social WG\""
     "Unread non-important messages"                                                 ?U)
    ("date:today..now AND NOT maildir:/Spam"                  "Today's messages"     ?T)
    ;("date:7d..now AND NOT maildir:/Spam"                     "Last 7 days"          ?w)
    ;("mime:image/* AND NOT maildir:/Spam"                     "Messages with images" ?p)
    ("flag:unread AND NOT flag:trashed AND maildir:/Spam"     "Unread spam"          ?s)
    ("flag:unread AND maildir:/Inbox.General"  "Unread general inbox" ?i)
    ("flag:unread AND (/Inbox.General OR /Mediagoblin OR \"/W3C Social WG\"" "Important messages)" ?I)
    ("flag:unread AND maildir:/Mediagoblin"  "MediaGoblin devel" ?m)
    ("flag:unread AND \"maildir:/MediaGoblin Tickets\""  "Unread general inbox" ?t)))

(load-file "~/devel/mu4e-uqueue/mu4e-uqueue.el")
(load-file "~/devel/mu4e-uqueue/uqueue-advice.el")

(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq mu4e~main-buffer-name "*mu4e-main*")

(setq mu4e-user-mail-address-list
      '("cwebber@dustycloud.org"
        "cwebber@mediagoblin.org"))
(setq mu4e-compose-dont-reply-to-self t)

(setq mu4e-compose-signature-auto-include nil)

(global-set-key (kbd "C-c m q") 'mu4e-uqueue)
(global-set-key (kbd "C-c q") 'mu4e-uqueue)

;; Only request contacts that have sent to us directly
(setq mu4e-compose-complete-only-personal t)
;; Don't update contacts after every update
(remove-hook 'mu4e-index-updated-hook 'mu4e~request-contacts)
