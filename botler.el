(add-to-list 'load-path "~/elisp/emacs-jabber")
(require 'jabber)

(load-file "~/.emacs.d/emacs-jabberbot-login.el")

(defun botler->appt-message-me (min-to-app new-time appt-msg)
  "Message me about an upcoming appointment."
  (jabber-send-message
   (jabber-find-connection "emacs@dustycloud.org")
   "cwebber@dustycloud.org" nil
   (format "Appointment %s: %s%s"
           (if (string-equal "0" min-to-app) "now"
             (format "in %s minute%s" min-to-app
                     (if (string-equal "1" min-to-app) "" "s")))
           new-time appt-msg)
   nil))

(defun botler->do-nothing ())

(setq appt-disp-window-function 'botler->appt-message-me)
(setq appt-delete-window-function 'botler->do-nothing)
