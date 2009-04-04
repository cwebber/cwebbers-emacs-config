;; ---------
;; Word count
;; ---------

(load "~/elisp/word-counter.el")
(require 'word-counter)
(global-set-key (kbd "C-c w") 'word-count)
