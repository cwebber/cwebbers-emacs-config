;; --------
;; Org mode
;; --------

(setq load-path (cons "~/elisp/org-mode/lisp" load-path))
(require 'org)
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)
(setq org-agenda-files "~/org/orgfiles.txt")
(setq org-id-locations-file "~/org/org-id-locations.txt")
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

(setq org-log-state-notes-into-drawer t)

(setq org-refile-targets '((org-agenda-files . (:level . 1))))
(setq org-refile-use-outline-path 'file)

; It's just too hard to deal with daily repeating tasks (octavia)
; if you see them every day in the future
; I am not confident this is the right option though.
(setq org-agenda-repeating-timestamp-show-all nil)

(setq org-archive-default-command 'org-archive-to-archive-sibling)

; Start weekly view from present day
(setq org-agenda-start-on-weekday nil)

;; Useful functions

(defun cwebber-org-update-roundup ()
  (with-current-buffer (or (find-buffer-visiting "~/org/ccommons.org")
                           (find-file-noselect "~/org/ccommons.org"))
    (save-excursion
      (beginning-of-buffer)
      (search-forward "\n* Roundup")
      (outline-next-heading)
      (backward-char)
      (let* ((roundup-entries
              (remove ""
                      (split-string
                       (shell-command-to-string
                        "python ~/org/scripts/read_roundup_csv.py") "\n")))
             (roundup-header-marker (point-marker))
             (filed-roundup-ids
              (remove nil (org-map-entries
                           '(org-entry-get (point) "ROUNDUPID")
                           nil 'tree))))
        (dolist (csvline roundup-entries)
          (let* ((split-entry (split-string csvline))
                 (entry-id (car split-entry))
                 (entry-title (combine-and-quote-strings (cdr split-entry))))
            (if (not (member entry-id filed-roundup-ids))
                (progn
                  (insert "\n\n")
                  (backward-char)
                  (org-insert-subheading t)
                  (insert (format "TODO [[roundup:%s]] %s" entry-id entry-title))
                  (org-entry-put (point) "ROUNDUPID" entry-id)
                  (hide-subtree)
                  (goto-char (marker-position roundup-header-marker))))))))))


;; -----------------
;; Appointment stuff
;; -----------------

(appt-activate)
(org-agenda-to-appt)
(require 'midnight)
(setq midnight-mode t)
(remove-hook 'midnight-hook 'clean-buffer-list)
(add-hook 'midnight-hook 'org-agenda-to-appt)

; This one is kinda annoying...
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

(setq org-clock-idle-time 15)