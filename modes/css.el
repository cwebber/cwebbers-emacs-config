;; ---------
;; CSS Mode
;; ---------

(load "~/elisp/css-mode.el")
(autoload 'css-mode "css-mode" "CSS editing mode" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
