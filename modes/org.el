;; --------
;; Org mode
;; --------

(setq load-path (cons "~/elisp/org-mode/lisp" load-path))
(require 'org)
(require 'org-id)
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)
(setq org-agenda-files "~/org/orgfiles.txt")
(setq org-id-track-globally nil)
;(setq org-id-locations-file "~/org/org-id-locations.txt")
;(setq org-agenda-include-diary t)
(setq org-hide-leading-stars t)
(setq org-log-done 'time)

(setq org-todo-keywords
      '((sequence "TODO" "DONE")
        (sequence "WAITING" "|" "DONE")
        (sequence "|" "CANCELED")))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

;; remember
(org-remember-insinuate)
;(define-key global-map "\C-cor" 'org-remember)
(define-key global-map "\C-coR" 'org-remember) ; used to be C-o r, here in case
                                               ; I need it
(define-key global-map "\C-cor" 'org-capture)
;(define-key global-map "\C-coc" 'org-capture)
(define-key global-map "\C-col" 'org-store-link)
(define-key global-map "\C-coj" 'org-clock-goto)
(define-key global-map "\C-cod" 'org-diet-hacky-jump-to-today)
;(define-key global-map "\C-cob" 'org-iswitchb)

(setq org-remember-delete-empty-lines-at-end nil)

(setq org-remember-templates
      '(("Todo" ?t "* TODO %?\n  %i\n  %a" "~/org/life.org" "Various Tasks")
        ("Event" ?e "* %^{Event} %^t\n  %a\n\n%?" "~/org/life.org" "Events")
        ("Journal" ?j "* %U %?\n\n  %i\n  %a" "~/org/journal.org")
        ("Weigh-in" ?w "* CAL-IN Diet for day %t
%^{Weight}p
| Food / Exercise | Calories | Quantity | Total |
|-----------------+----------+----------+-------|
| %?%&                |          |          |       |
|-----------------+----------+----------+-------|
| Total           |          |          |       |
#+TBLFM: $4=$2*$3::$LR4=vsum(@2$4..@-I$4)

" "~/org/diet.org" "Daily Logs")
        ("Note" ?n "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n  %a"
         "~/org/notes.org" "General Notes")
        ("Idea" ?i "* %^{Title}\n  %i\n  %a" "~/org/ideas.org")))


(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/org/life.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("e" "Event" entry
         (file+headline "~/org/life.org" "Events")
         "* %^{Event} %^t\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("j" "Journal" entry
         (file+headline "~/org/journal.org" "")
         "* %U %?\n\n  %i\n  %a" :prepend t :empty-lines 1)
        ("w" "Weigh-in" entry
         (file+headline "~/org/diet.org" "Daily Logs")
         "* CAL-IN Diet for day %t\n%^{Weight}p\n| Food / Exercise | Calories | Quantity | Total |\n|-----------------+----------+----------+-------|\n| %?                |          |          |       |\n|-----------------+----------+----------+-------|\n| Total           |          |          |       |\n#+TBLFM: $4=$2*$3::$LR4=vsum(@2$4..@-I$4)\n\n"
         :prepend t :empty-lines 1)
        ("n" "Note" entry
         (file+headline "~/org/notes.org" "General Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n  %i\n  %a"
         :prepend t :empty-lines 1)
        ("i" "Idea" entry
         (file+headline "~/org/ideas.org" "")
         "* %^{Title}\n  %i\n  %a" :prepend t :empty-lines 1)
        ("c" "CC work-related items")
        ("ct" "CC Todo" entry
         (file+headline "~/org/ccommons.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("ce" "CC Event" entry
         (file+headline "~/org/ccommons.org" "Events")
         "* %^{Event} %^t\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("cn" "CC Note" entry
         (file+headline "~/org/ccommons.org" "Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n  %i\n  %a"
         :prepend t :empty-lines 1)))

(setq org-columns-default-format "%30ITEM %TODO %DEADLINE %TAGS")

; Always file things at the start of a tree rather than at the end
(setq org-reverse-note-order t)

(setq org-log-state-notes-into-drawer t)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 8))))
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


(defun cwebber-org-pull-up-agenda (&optional open-same-window)
  "Switch to the org agenda, or prompt for new one if one does not exist"
  (interactive "P")
  (let ((agenda-buffer (get-buffer "*Org Agenda*")))
    (if agenda-buffer
        (if open-same-window
            (switch-to-buffer agenda-buffer)
          (switch-to-buffer-other-window agenda-buffer))
      (org-agenda))))

(define-key global-map "\C-coa" 'cwebber-org-pull-up-agenda)
(define-key global-map [XF86Favorites] 'cwebber-org-pull-up-agenda)
(define-key global-map [f5] 'cwebber-org-pull-up-agenda)


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

;(setq org-clock-idle-time 15)
(setq org-clock-idle-time nil)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; -----------
;; Babel stuff
;; -----------

(require 'ob-python)
(require 'ob-sh)
(require 'ob-gnuplot)

; Don't prompt me all the time about evaluating code blocks

(setq org-confirm-babel-evaluate nil)

;; -----------
;; Other stuff
;; -----------

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

; hacky diet stuff
(defun org-diet-hacky-jump-to-today ()
  "Really hacky function to jump to today based on the assumption
    that we can find the first Total line"
  (interactive)
  (switch-to-buffer (get-file-buffer "~/org/diet.org"))
  (beginning-of-buffer)
  (search-forward-regexp "^| Total")
  (beginning-of-line)
  (previous-line))

; Make org the default scratch

(setq initial-major-mode 'org-mode)
(with-current-buffer "*scratch*"
  (if (not (eq major-mode initial-major-mode))
      (funcall initial-major-mode)))
(setq initial-scratch-message
      (purecopy "\
# Scratch!
# --------
# This buffer is for notes you don't want to save, etc.
"))
