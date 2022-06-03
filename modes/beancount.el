(add-to-list 'auto-mode-alist '("\\.bnct\\'" . beancount-mode))

(defun beancount-indent-and-align (&optional arg)
  (interactive "P")
  (beancount-tab-dwim arg)
  (beancount-align-to-previous-number))

(define-key beancount-mode-map (kbd "TAB") 'beancount-indent-and-align)
