(defun cwebber/wisp2lisp ()
  (interactive)
  (begin-excursion
   (set-buffer "*wisp2lisp*")
   (erase-buffer))
  (call-process "wisp2lisp" nil "*wisp2lisp*" nil (buffer-file-name))
  (switch-to-buffer "*wisp2lisp*"))
