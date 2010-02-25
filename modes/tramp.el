;; ---------
;; Tramp
;; ---------
(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-method-alist '("localhost" "" "sudo"))
(setq tramp-backup-directory-alist backup-directory-alist)
(add-to-list 'tramp-default-proxies-alist
             '("\\.creativecommons\\.org\\'" "\\`root\\'" "/ssh:%h:"))
