(require 'geiser)
(setq geiser-default-implementation 'guile)
(setq geiser-mode-smart-tab-p t)

(defun cwebber/geiser-completion-prefs ()
  (auto-complete-mode -1)
  (company-mode 1))

(add-hook 'geiser-mode-hook 'cwebber/geiser-completion-prefs)
(add-hook 'geiser-repl-mode-hook 'cwebber/geiser-completion-prefs)

