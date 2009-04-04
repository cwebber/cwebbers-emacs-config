;; --------
;; Org mode
;; --------

(setq load-path (cons "~/elisp/org-mode/lisp" load-path))
(require 'org)
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)