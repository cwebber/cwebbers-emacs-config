;; ---------
;; BBDB
;; ---------

;; Keeping contacts the Orwell way

;; Do we really need to run the latest version?
;(setq load-path (add-to-list 'load-path "~/elisp/bbdb/lisp/"))

(require 'bbdb)
(bbdb-initialize 'gnus 'message)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(global-set-key (kbd "C-c b") 'bbdb)
