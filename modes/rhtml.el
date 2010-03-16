;;; rhtml-mode
(add-to-list 'load-path "~/elisp/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
	  (lambda () (rinari-launch)))
