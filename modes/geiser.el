(require 'geiser)
(setq geiser-default-implementation 'guile)
(setq geiser-mode-smart-tab-p t)

(defun cwebber/geiser-completion-prefs ()
  (setq auto-complete-mode nil)
  (setq company-mode t))

(add-hook 'geiser-mode-hook 'cwebber/geiser-completion-prefs)
(add-hook 'geiser-repl-mode-hook 'cwebber/geiser-completion-prefs)

