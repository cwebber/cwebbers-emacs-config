;; ---------
;; emacs-w3m
;; ---------

(setq load-path (add-to-list 'load-path "~/elisp/emacs-w3m/"))
(require 'w3m)
(setq w3m-use-cookies t)

(defun cwebber/w3m-save-link ()
  "Copy the link at point to the kill ring."
  (interactive)
  (let ((link (w3m-anchor)))
    (if link
        (kill-new link)
      (message "Point is not on a link."))))

(global-set-key (kbd "C-c k") 'cwebber/w3m-save-link)
