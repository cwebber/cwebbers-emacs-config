; (load-file "~/elisp/highlight-sexps.el")

(setq hl-sexp-background-colors '("#201e1b" "#2b2925"))
(add-hook 'lisp-mode-hook 'highlight-sexps-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-sexps-mode)
