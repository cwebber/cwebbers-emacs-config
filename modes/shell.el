(defun shell-set-pager-nothing ()
  (comint-send-string (get-buffer-process (current-buffer)) "export PAGER=\"\"")
  (comint-send-string (get-buffer-process (current-buffer)) "\n"))
    
