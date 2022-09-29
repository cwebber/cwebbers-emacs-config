(require 'org-roam)
(setq org-roam-directory (file-truename "~/org/roam"))
(org-roam-db-autosync-mode)

(define-key global-map "\C-cri" 'org-roam-node-insert)
(define-key global-map "\C-crc" 'org-roam-capture)
(define-key global-map "\C-crf" 'org-roam-node-find)
