;; ---------
;; Tramp
;; ---------
(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-method-alist '("localhost" "" "sudo"))
(setq tramp-backup-directory-alist backup-directory-alist)
(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))

;; Make sure we work on remote guixsd machines :)
;; probably only helps if you start on a guixsd machine..!
(setq tramp-remote-path
      (append tramp-remote-path
              '(tramp-own-remote-path
                "/run/current-system/profile/bin" "/run/current-system/profile/sbin"
                "~/.guix-profile/bin" "~/.guix-profile/sbin")))
