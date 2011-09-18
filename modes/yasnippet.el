(require 'yasnippet)

(yas/initialize)

; Our snippets
(setq yas/root-directory "~/.config/emacs/yas-snippets")
(yas/load-directory "~/.config/emacs/yas-snippets/")

; third party snippets
(yas/load-directory "~/elisp/yasnippet-snippets/")

;; Also putting hippie-expand here.  Maybe should be its own file..
(define-key global-map "\M-/" 'hippie-expand)

(setq hippie-expand-try-functions-list
      (cons 'yas/hippie-try-expand hippie-expand-try-functions-list))

; Fix orgmode issue with yas
(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

