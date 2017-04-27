(require 'smartparens)
(require 'smartparens-config)

; Use default keygindings
(sp-use-smartparens-bindings)

;; Less nasty face for pair-overlay

(set-face-attribute 'sp-pair-overlay-face nil :background "#443152")
;;; snow edition
;; (set-face-attribute 'sp-pair-overlay-face nil :background "old lace")

;;; Lots borrwowed from https://github.com/Fuco1/smartparens/wiki/Example-configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;; pair management

(sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)

;;; html-mode
(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))

;;; lisp modes
(sp-with-modes sp--lisp-modes
  (sp-local-pair "(" nil :bind "C-("))

(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(add-hook 'hy-mode-hook 'smartparens-mode)
(add-hook 'inferior-lisp-mode-hook 'smartparens-mode)
(add-hook 'scheme-mode-hook 'smartparens-mode)
(add-hook 'lisp-mode-hook 'smartparens-mode)

;; Of course I want (|)() when at |(), damnit
(setq sp-autoinsert-if-followed-by-same 0)
