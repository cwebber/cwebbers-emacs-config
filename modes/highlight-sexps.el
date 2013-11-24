; (load-file "~/elisp/highlight-sexps.el")

(setq hl-sexp-background-colors '("#445255" "#353d3f"))
(add-hook 'lisp-mode-hook 'highlight-sexps-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-sexps-mode)
