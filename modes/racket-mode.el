(require 'racket-mode)
(require 'racket-xp)

;;; wtf why isn't it working
;; (add-hook ’racket-mode-hook ’racket-xp-mode)

(put 'let-on 'racket-indent-function 1)
