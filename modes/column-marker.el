;; ---------
;; Column-marker
;; ---------

(load "~/elisp/column-marker.el")
(add-hook 'python-mode-hook
          (lambda () (interactive) (column-marker-1 80)))
