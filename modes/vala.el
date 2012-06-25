; Remove tab nastiness

(defun vala-remove-tab-nastiness ()
  (setq indent-tabs-mode nil))

(add-hook 'vala-mode-hook 'vala-remove-tab-nastiness)
