(setq mu4e-maildir       "~/Maildir"   ;; top-level Maildir
      mu4e-sent-folder   "/personal/sent-to-misc"       ;; where do i keep sent mail?
      mu4e-drafts-folder "/personal/drafts"     ;; where do i keep half-written mail?
      mu4e-trash-folder  "/personal/trash")     ;; where do i move deleted mail?

;; <mark_weaver> paroneayea: it's a hack, but /run/current-system will exist on a
;;               GuixSD system and not on Debian.
;; <mark_weaver> I hope such a test will never end up in any published software.
(if (file-exists-p "/run/current-system")
    (add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp/mu4e/"))
; (setq mu4e-mu-binary "/home/cwebber/programs/mu/mu/mu")

(require 'mu4e)
; (require 'org-mu4e)
(require 'mu4e-contrib)

; (setq mu4e-msg2pdf "/usr/bin/msg2pdf")
(setq mu4e-msg2pdf "/home/cwebber/programs/mu/toys/msg2pdf/msg2pdf")

(setq mu4e-get-mail-command "/home/cwebber/bin/fetch-mail.sh")
(setq mu4e-html2text-command 'mu4e-shr2text)
;; (setq mu4e-html2text-command "html2text -utf8 -width 72")
;;;; When all goes badly:
;; (setq mu4e-html2text-command "cat")

(setq mu4e-maildir-shortcuts
      '(("/personal/Inbox.General"     . ?i)
        ("/personal/CC Staff"   . ?c)
        ("/personal/Spam"       . ?s)
        ("/personal/sent-to-misc" . ?S)))

(setq smtpmail-queue-mail  nil  ;; start in non-queuing mode
      smtpmail-queue-dir   "~/Maildir/queue/cur")

(setq cwebber/mu4e-important-lists
      "(maildir:/personal/Inbox.General OR maildir:/personal/Mediagoblin OR \"maildir:/personal/W3C Social WG\")")

(load-file "~/devel/mu4e-uqueue/mu4e-uqueue.el")
(load-file "~/devel/mu4e-uqueue/uqueue-advice.el")

(require 'mu4e-actions)

(add-to-list 'mu4e-view-actions
  '("ViewInBrowser" . mu4e-action-view-in-browser) t)
(add-to-list 'mu4e-view-actions
  '("GitApply" . mu4e-action-git-apply-patch) t)
(add-to-list 'mu4e-view-actions
  '("MboxGitApply" . mu4e-action-git-apply-mbox) t)

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

(setq mu4e-cache-maildir-list t)

;; (setq mu4e-contexts
;;       (list (make-mu4e-context
;;              :name "Any")
;;             (make-mu4e-context
;;              :name "Personal"
;;              ;; we match based on the contact-fields of the message
;;              :enter-func (lambda () (mu4e-message "Personal mail"))
;;              :match-func (lambda (msg)
;;                            (when msg
;;                              (not (string-match-p "^/Spritely" (mu4e-message-field msg :maildir)))))
;;              :vars '((user-mail-address	    . "cwebber@dustycloud.org")))
;;             (make-mu4e-context
;;              :name "Work"
;;              :enter-func (lambda () (mu4e-message "Work mail"))
;;              :match-func (lambda (msg)
;;                            (when msg
;;                              (mu4e-message-contact-field-matches msg
;;                                                                  :to "cwebber@dustycloud.org")))
;;              )
;;          ,(make-mu4e-context
;;            :name "Work"
;;            :enter-func (lambda () (mu4e-message "Switch to the Work context"))
;;            ;; no leave-func
;;            ;; we match based on the maildir of the message
;;            ;; this matches maildir /Arkham and its sub-directories
;;            :match-func (lambda (msg)
;;                          (when msg
;;                            (string-match-p "^/Arkham" (mu4e-message-field msg :maildir))))
;;            :vars '( ( user-mail-address	     . "aderleth@miskatonic.example.com" )
;;                     ( user-full-name	     . "Alice Derleth" )
;;                     ( message-user-organization . "Miskatonic University" )
;;                     ( mu4e-compose-signature  .
;;                       (concat
;;                        "Prof. Alice Derleth\n"
;;                        "Miskatonic University, Dept. of Occult Sciences\n"))))

;;          ,(make-mu4e-context
;;            :name "Cycling"
;;            :enter-func (lambda () (mu4e-message "Switch to the Cycling context"))
;;            ;; no leave-func
;;            ;; we match based on the maildir of the message; assume all
;;            ;; cycling-related messages go into the /cycling maildir
;;            :match-func (lambda (msg)
;;                          (when msg
;;                            (string= (mu4e-message-field msg :maildir) "/cycling")))
;;            :vars '( ( user-mail-address	     . "aderleth@example.com" )
;;                     ( user-full-name	     . "AliceD" )
;;                     ( mu4e-compose-signature  . nil)))))
