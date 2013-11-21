(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("django" . "\\.html\\'")))

(defun cwebber-web-mode-customizations ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook 'cwebber-web-mode-customizations)
