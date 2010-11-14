(add-to-list 'load-path "~/elisp/yasnippet")
(require 'yasnippet)

(yas/initialize)

;; We should make a snippet directory?
(yas/load-directory "~/elisp/yasnippet/snippets/")

; third party snippets
(yas/load-directory "~/elisp/yasnippet-snippets/")

; Our snippets
(setq yas/root-directory "~/.config/emacs/yas-snippets")
(yas/load-directory "~/.config/emacs/yas-snippets/")

;; Also putting hippie-expand here.  Maybe should be its own file..
(global-set-key "\M-/" 'hippie-expand)

(setq hippie-expand-try-functions-list
      (cons 'yas/hippie-try-expand hippie-expand-try-functions-list))

; Fix orgmode issue with yas
(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

