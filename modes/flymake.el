;;; --------
;;; Flymake / Pyflakes
;;; --------

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
;(remove-hook 'find-file-hook 'flymake-find-file-hook)
(load-file "~/elisp/flymake-cursor.el")

(setq flymake-allowed-file-name-masks
      '(("\\.py\\'" flymake-pyflakes-init)
        ("\\.c\\'" flymake-simple-make-init)
        ("\\.cpp\\'" flymake-simple-make-init)
        ;("\\.xml\\'" flymake-xml-init)
        ;("\\.html?\\'" flymake-xml-init)
        ("\\.cs\\'" flymake-simple-make-init)
        ("\\.p[ml]\\'" flymake-perl-init)
        ("\\.php[345]?\\'" flymake-php-init)
        ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
        ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
        ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
        ("\\.tex\\'" flymake-simple-tex-init)
        ("\\.idl\\'" flymake-simple-make-init)))
