(require 'highlight-parentheses)

(add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'hy-mode-hook 'highlight-parentheses-mode)
(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'inferior-lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'scheme-mode-hook 'highlight-parentheses-mode)
(add-hook 'racket-mode-hook 'highlight-parentheses-mode)

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
(setq cwebber/darker-highlight-parentheses
      (cons "#465255"
            (mapcar (lambda (x) "#3d4749")
                    (number-sequence 1 100))))
;; Lighter edition
(setq cwebber/lighter-highlight-parentheses
      (cons "#c3ccce"
            (mapcar (lambda (x) "#d2dbdb")
                    (number-sequence 1 100))))

(setq hl-paren-background-colors
      cwebber/darker-highlight-parentheses)


(setq cwebber/known-lisp-modes '(lisp-mode
                                 emacs-lisp-mode scheme-mode
                                 hy-mode))

(defun cwebber/reset-highlight-parentheses ()
  (interactive)
  (mapc
   (lambda (buffer)
     (save-excursion
       (set-buffer buffer)
       (when (member major-mode cwebber/known-lisp-modes)
         ;; Toggle highlight-parentheses-mode off and on again to reset the colors
         (highlight-parentheses-mode)
         (highlight-parentheses-mode))))
   (buffer-list)))

(defun cwebber/enable-light-parentheses ()
  (interactive)
  (setq hl-paren-background-colors
        cwebber/lighter-highlight-parentheses)
  (cwebber/reset-highlight-parentheses))

(defun cwebber/enable-dark-parentheses ()
  (interactive)
  (setq hl-paren-background-colors
        cwebber/darker-highlight-parentheses)
  (cwebber/reset-highlight-parentheses))

;; Make the parenthesis' matched by hl-paren-face bold.
;;
;; Not sure if I like this or not!  It looks nice but moves around
;; the text a bit.
; (set-face-attribute 'hl-paren-face nil :bold t)

