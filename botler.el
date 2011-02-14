(add-to-list 'load-path "~/elisp/emacs-jabber")
(require 'jabber)

(load-file "~/.emacs.d/emacs-jabberbot-login.el")

(defun botler->appt-message-me (min-to-app new-time appt-msg)
  "Message me about an upcoming appointment."
  (let ((message-body
         (format "Appointment %s: %s%s"
           (if (string-equal "0" min-to-app) "now"
             (format "in %s minute%s" min-to-app
                     (if (string-equal "1" min-to-app) "" "s")))
           new-time appt-msg)))
    (jabber-send-sexp
     (jabber-find-connection "emacs@dustycloud.org")
     `(message ((to . "cwebber@dustycloud.org")
                (type . "normal"))
                (body () ,message-body)))))

; I don't care when people come online to my bot's roster.
(setq jabber-alert-presence-hooks nil)

(setq appt-disp-window-function 'botler->appt-message-me)
(setq appt-delete-window-function (lambda ()))

(setq appt-display-inverval 5) ; maybe 6 is better?
