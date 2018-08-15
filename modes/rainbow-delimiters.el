(require 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'hy-mode-hook 'rainbow-delimiters-mode)
(add-hook 'inferior-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'racket-mode-hook 'rainbow-delimeters-mode)

(setq rainbow-delimiters-max-face-count 11)
