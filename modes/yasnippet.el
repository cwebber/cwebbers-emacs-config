(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.config/emacs/yas-snippets"   ;; personal snippets
        "~/elisp/yasnippet-snippets/"  ; third party snippets
        ))

;; Also putting hippie-expand here.  Maybe should be its own file..
(define-key global-map "\M-/" 'hippie-expand)

(setq hippie-expand-try-functions-list
      (cons 'yas/hippie-try-expand hippie-expand-try-functions-list))

; Fix orgmode issue with yas
(add-hook 'org-mode-hook
          (lambda ()
            (org-set-local 'yas/trigger-key [tab])
            (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))


; change dropdown behavior
;(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt yas/ido-prompt yas/completing-prompt yas/no-prompt))

(yas-global-mode 1)

