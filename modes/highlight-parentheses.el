(require 'highlight-parentheses)

(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'hy-mode-hook 'highlight-parentheses-mode)
(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)

;; ; Use naquadah colors
;; (setq hl-paren-colors
;;       (list
;;        (naquadah-get-colors 'gradient-1)
;;        (naquadah-get-colors 'gradient-2)
;;        (naquadah-get-colors 'gradient-3)
;;        (naquadah-get-colors 'gradient-4)
;;        (naquadah-get-colors 'gradient-5)
;;        (naquadah-get-colors 'gradient-6)
;;        (naquadah-get-colors 'gradient-7)
;;        (naquadah-get-colors 'gradient-8)
;;        (naquadah-get-colors 'gradient-9)
;;        (naquadah-get-colors 'gradient-10)
;;        (naquadah-get-colors 'gradient-11)
;;        ))

(setq hl-paren-colors nil)

; Have a light first parenthesis background then unlimited slightly darker ones
(setq hl-paren-background-colors
      (cons "#465255"
            (mapcar (lambda (x) "#3d4749")
                    (number-sequence 1 100))))

;; Make the parenthesis' matched by hl-paren-face bold.
;;
;; Not sure if I like this or not!  It looks nice but moves around
;; the text a bit.
; (set-face-attribute 'hl-paren-face nil :bold t)

