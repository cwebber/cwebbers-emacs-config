;; --------
;; Org mode
;; --------

(setq load-path (cons "~/elisp/org-mode/lisp" load-path))
(require 'org)
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)
(setq org-agenda-files "~/org/orgfiles.txt")
(setq org-agenda-include-diary t)
(setq org-hide-leading-stars t)
(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "TODO" "DONE")
        (sequence "|" "CANCELED")))

;; remember
(org-remember-insinuate)
(define-key global-map "\C-cor" 'org-remember)
(define-key global-map "\C-cm" 'org-remember)
(define-key global-map "\C-col" 'org-store-link)
;(define-key global-map "\C-cob" 'org-iswitchb)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/life.org" "Various Tasks")
        ("Schedule" ?s "* %^{Event}%?\n  SCHEDULED: %^t\n  %a" "~/org/life.org" "Events")
        ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/journal.org")
        ("Weigh-in" ?w "* %t
%^{Weight}p

| Food / Exercise | Calories | Quantity | Total |
|-----------------+----------+----------+-------|
| %?%&                |          |          |       |
|-----------------+----------+----------+-------|
| Total           |          |          |       |
#+TBLFM: $4=$2*$3::$LR4=vsum(@2$4..@-I$4)

" "~/org/diet.org" "Daily Logs")
        ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/ideas.org")))

(setq org-columns-default-format "%30ITEM %TODO %DEADLINE %TAGS")

; Always file things at the start of a tree rather than at the end
(setq org-reverse-note-order t)

