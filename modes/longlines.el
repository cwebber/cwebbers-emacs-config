;; ---------
;; LongLines
;; ---------

;; act (more) like a word processor
(load "~/elisp/longlines.el")
(add-to-list 'auto-mode-alist '("\\.ll\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . text-mode))
