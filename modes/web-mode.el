(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))

(setq web-mode-engines-alist
      '(("django" . "\\.html\\'")))

(defun cwebber-web-mode-customizations ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook 'cwebber-web-mode-customizations)

;; ;; More tango-y colors
;; (set-face-attribute 'web-mode-html-tag-face nil
;;                     :foreground (naquadah-get-colors 'sky-blue-1))
;; (set-face-attribute 'web-mode-html-tag-bracket-face nil
;;                     :foreground (naquadah-get-colors 'aluminium-4))
