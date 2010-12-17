(ido-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)

(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order
      '(".org" ".txt" ".py" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))

; Ignore object files
(setq ido-ignore-extensions t)

;; Maybe we can disable tramp stuff via this?
;(setq ido-work-directory-list-ignore-regexps 