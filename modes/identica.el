(add-to-list 'load-path "~/elisp/emacs-oauth")

(load-file "~/elisp/identica-mode/identica-mode.el")
(require 'identica-mode)

(setq identica-update-status-method 'edit-buffer)

;; ; We'll set the username here but NOT our password.
;; (setq identica-username nil)

; Let's not overload ourselves
(setq identica-display-max-dents 500)
