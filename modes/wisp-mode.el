(require 'wisp-mode)
(require 'scheme)
(add-hook 'lisp-mode-hook 'rainbow-identifiers-mode)
(add-hook 'scheme-mode-hook 'rainbow-identifiers-mode)

(defun cwebber/wisp2lisp ()
  (interactive)
  (let ((current-line (line-number-at-pos)))
    (save-excursion
      (set-buffer (get-buffer-create "*wisp2lisp*"))
      (erase-buffer)
      (scheme-mode))
    (call-process "wisp2lisp" nil "*wisp2lisp*" nil (buffer-file-name))
    (when (called-interactively-p)
      (switch-to-buffer-other-window "*wisp2lisp*")
      (beginning-of-buffer)
      (forward-line (- current-line 1)))))

(define-key wisp-mode-map (kbd "C-c C-w") 'cwebber/wisp2lisp)

(defun cwebber/wisp2lisp-eval-buffer ()
  (interactive)
  (cwebber/wisp2lisp)
  (save-excursion
    (set-buffer "*wisp2lisp*")
    (geiser-eval-buffer)))

(define-key wisp-mode-map (kbd "C-c C-b") 'cwebber/wisp2lisp-eval-buffer)

(defun cwebber/wisp2lisp-switch-to-geiser (arg)
  (interactive "P")
  (cwebber/wisp2lisp)
  (let ((cur-buf (current-buffer)))
    (set-buffer "*wisp2lisp*")
    (geiser-mode-switch-to-repl arg)
    (set-buffer cur-buf)))

(define-key wisp-mode-map (kbd "C-c C-z") 'cwebber/wisp2lisp-switch-to-geiser)


