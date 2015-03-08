(add-to-list 'load-path "/home/cwebber/devel/guix/emacs")

;; Not sure this helps :(
(setenv "GUILE_LOAD_PATH" "/home/cwebber/devel/guix")
(setenv "GUILE_LOAD_COMPILED_PATH" "/home/cwebber/devel/guix")

(setq guix-helper-file "/home/cwebber/devel/guix/emacs/guix-helper.scm")

(setq guix-load-path "/home/cwebber/devel/guix/emacs")

(require 'guix-init)
