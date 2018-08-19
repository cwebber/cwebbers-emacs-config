; Make erc tracking come after everything else
(setq erc-track-position-in-mode-line 'after-modes)

; Don't show me the time.
; ... not sure of a nicer way to do this :)
(call-interactively 'display-time-mode)

; borrowed heavily from
; http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
(setq-default mode-line-format
      (list
       "[" ;; insert vs overwrite mode, input-method in a tooltip
       '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
                           'face 'font-lock-preprocessor-face
                           'help-echo (concat "Buffer is in "
                                              (if overwrite-mode "overwrite" "insert") " mode")))

       ;; was this buffer modified since the last save?
       '(:eval (when (buffer-modified-p)
                 (concat ","  (propertize "Mod"
                                          'face 'font-lock-warning-face
                                          'help-echo "Buffer has been modified"))))

       ;; is this buffer read-only?
       '(:eval (when buffer-read-only
                 (concat ","  (propertize "RO"
                                          'face 'font-lock-type-face
                                          'help-echo "Buffer is read-only"))))  
       "] "

       ;; the buffer name; the file name as a tool tip
       '(:eval (propertize "%b " 'face 'font-lock-keyword-face
                           'help-echo (buffer-file-name)))

       ;; line and column
       "(" ;; '%02' to set to 2 chars at least; prevents flickering
       (propertize "%02l" 'face 'font-lock-type-face) ","
       ; warn if we go over 80 characters
       '(:eval (propertize "%02c" 'face
                           (if (>= (current-column) 80)
                               'font-lock-warning-face
                        'font-lock-type-face)))
       ") "

       ;; the current major mode for the buffer.
       "["

       '(:eval (propertize "%m" 'face 'font-lock-string-face
                           'help-echo buffer-file-coding-system))
       "]"

       '(vc-mode vc-mode)

       " "

       '(global-mode-string global-mode-string)

       " "

       ;; '(:eval (when nyan-mode (list (nyan-create) " ")))

       '(:eval (when (and erc-track-mode cwebber/show-erc-in-mode-line)
                 (list erc-modified-channels-object)))

       ;; i don't want to see minor-modes; but if you want, uncomment this:
       minor-mode-alist  ;; list of minor modes
       "%-" ;; fill with '-'
       ))
 

(defvar cwebber/show-erc-in-mode-line t)

(defun cwebber/toggle-show-erc ()
  (interactive)
  (if cwebber/show-erc-in-mode-line
      (setq cwebber/show-erc-in-mode-line nil)
    (setq cwebber/show-erc-in-mode-line t)))

(global-set-key (kbd "C-c E") 'cwebber/toggle-show-erc)

