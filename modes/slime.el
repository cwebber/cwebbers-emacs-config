;; ---------
;; Slime mode
;; ---------

;; (setq inferior-lisp-program "/usr/bin/sbcl")
;; (add-to-list 'load-path "/usr/share/emacs23/site-lisp/slime/")
;; (add-to-list 'load-path "/usr/share/common-lisp/source/slime/")
;; (setq slime-backend "/usr/share/common-lisp/source/slime/swank-loader.lisp")
(require 'slime)
(slime-setup '(slime-repl))
