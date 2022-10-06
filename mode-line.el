; Make erc tracking come after everything else
(setq erc-track-position-in-mode-line 'after-modes)

; Don't show me the time.
; ... not sure of a nicer way to do this :)
(display-time-mode nil)

; borrowed heavily from
; http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html
(setq-default mode-line-format
      (list
       '(:eval (when overwrite-mode
                 (propertize
                  "Ovr"
                  'face 'font-lock-preprocessor-face
                  'help-echo (concat "Buffer is in "
                                     (if overwrite-mode "overwrite" "insert") " mode"))))

       ;; was this buffer modified since the last save?
       '(:eval (when (buffer-modified-p)
                 (propertize "Mod"
                                           'face 'font-lock-warning-face
                                           'help-echo "Buffer has been modified")))

       ;; is this buffer read-only?
       '(:eval (when buffer-read-only
                 (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only")))  
       " "

       ;; the buffer name; the file name as a tool tip
       '(:eval (propertize "%b " 'face 'font-lock-keyword-face
                           'help-echo (buffer-file-name)))

       ;; line and column
       (propertize "%02l," 'face 'font-lock-type-face)
       ; warn if we go over 80 characters
       '(:eval (propertize "%02c" 'face
                           (if (>= (current-column) 80)
                               'font-lock-warning-face
                        'font-lock-type-face)))
       " "

       mode-name

       " "

       ;; revision control info
       '(vc-mode vc-mode)

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

