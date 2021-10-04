(require 'geiser)
(require 'geiser-guile)
(setq geiser-default-implementation 'guile)
(setq geiser-active-implementations '(guile mit racket))
(setq geiser-mode-smart-tab-p t)

(defun cwebber/geiser-completion-prefs ()
  (auto-complete-mode -1)
  (company-mode 1))

(add-hook 'geiser-mode-hook 'cwebber/geiser-completion-prefs)
(add-hook 'geiser-repl-mode-hook 'cwebber/geiser-completion-prefs)

;;; This no longer works...
;; (setq geiser-guile-binary '("/home/cwebber/devel/guix/pre-inst-env" "guile"))

(with-eval-after-load 'geiser-guile
  (add-to-list 'geiser-guile-load-path "~/devel/guix"))

(with-eval-after-load 'yasnippet
  (add-to-list 'yas-snippet-dirs "~/devel/guix/etc/snippets"))

