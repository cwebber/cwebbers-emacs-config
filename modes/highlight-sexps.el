; (load-file "~/elisp/highlight-sexps.el")

(setq hl-sexp-background-colors '("#313837" "#2e3435"))
(add-hook 'lisp-mode-hook 'highlight-sexps-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-sexps-mode)
