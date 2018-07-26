(require 'nodejs-repl)

;; (setq nodejs-repl-command "guix")
;; (setq nodejs-repl-arguments
;;       '("environment" "--ad-hoc" "node" "--" "node"))

(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
            ;; (define-key js-mode-map (kbd "C-c C-b") 'nodejs-repl-send-buffer)
            ))

