;; --------
;; Org mode
;; --------

(require 'org)
(require 'org-id)
(require 'org-install)

; Load stuff from http://doc.norang.ca/org-mode.html
(load-file "~/.config/emacs/modes/org-norang.el")

(global-set-key (kbd "C-c a") 'org-agenda)

;; why did they unbind this
(org-defkey org-mode-map [(control tab)] 'org-force-cycle-archived)

(setq org-export-html-toplevel-hlevel 2)
(setq org-export-babel-evaluate nil)
(setq org-agenda-files "~/org/orgfiles.txt")
(setq org-id-track-globally nil)
(setq org-link-to-org-use-id nil)
;(setq org-id-locations-file "~/org/org-id-locations.txt")
;(setq org-agenda-include-diary t)
(setq org-agenda-timegrid-use-ampm t)
(setq org-agenda-include-diary nil)
; (setq org-hide-leading-stars t)
(setq org-log-done 'time)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

(setq org-todo-keywords
      '((sequence "TODO" "DONE")
        (sequence "NEXT" "DONE")
        (sequence "WAITING" "|" "DONE")
        (sequence "|" "CANCELED")
        ; We don't always want this... only if we don't mostly care to
        ; pay attention to it.  Sometimes WAITING is better.
        (sequence "|" "PASSED-OFF")
        (sequence "|" "DONE-NOT-ME")
        (sequence "BILL-THIS" "PAYMENT-WAITING" "RECORD-INCOME" "|" "PAID")))

(setq org-todo-keyword-faces
      '(("CANCELED" . (:foreground "orange" :weight bold))
        ("NEXT" . (:foreground "DeepPink2" :weight bold))
        ("DONE-NOT-ME" . (:foreground "SpringGreen4" :weight bold))
        ("PASSED-OFF" . (:foreground "peru" :weight bold))
        ("CAL-CANCEL" . (:foreground "orange" :weight bold))
        ("WAITING" . (:foreground "dodger blue" :weight bold))
        ("PAYMENT-WAITING" . (:foreground "orchid" :weight bold))
        ("PAID" . (:foreground "sea green" :weight bold))
        ("FOODLIST-OUT" . (:foreground "#4e9a06" :weight bold))
        ))

; Complete with org-complete (does a fallback to hippie-expand automatically)
;(define-key org-mode-map "\M-/" 'org-complete)

;; We want the lowest and "default" priority to be E.  That way
;; when we calculate the agenda, any task that isn't specifically
;; marked with a priority or SCHEDULED/DEADLINE won't show up.
(setq org-default-priority ?E)
(setq org-lowest-priority ?E)

;; These priority faces look good 
(setq org-priority-faces
      '((?A . "DeepPink1")
        (?B . "light sea green")
        (?C . "slate blue")
        (?D . "#f0640f")))

(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
(setq org-habit-show-done-always-green t)

(define-key global-map "\C-cor" 'org-capture)
;(define-key global-map "\C-coc" 'org-capture)
(define-key global-map "\C-col" 'org-store-link)
(define-key global-map "\C-coj" 'org-clock-goto)
(define-key global-map "\C-coJ" (lambda () (interactive) (org-clock-goto t)))

(define-key global-map "\C-cod" 'org-diet-hacky-jump-to-today)
;(define-key global-map "\C-cob" 'org-iswitchb)

(setq org-remember-delete-empty-lines-at-end nil)

(setq org-capture-templates
      '(("t" "Todo" entry
         (file+headline "~/org/life.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("e" "Event" entry
         (file+headline "~/org/life.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("j" "Journal" entry
         (file+headline "~/org/journal.org" "")
         "* %U %?\n\n  %i\n  %a" :prepend t :empty-lines 1)
        ("w" "Weigh-in" entry
         (file+headline "~/org/diet.org" "Daily Logs")
         "* CAL-IN Diet for day %t
%^{Weight}p
| Food / Exercise | Calories | Quantity | Total |
|-----------------+----------+----------+-------|
| %?                |          |          |       |
|-----------------+----------+----------+-------|
| Total           |          |          |       |
#+TBLFM: $4=$2*$3;%.0f::@>$4=vsum(@2$4..@-I$4)

"
         :prepend t :empty-lines 1)
        ("W" "Weigh-in (no table)" entry
         (file+headline "~/org/diet.org" "Daily Logs")
         "* Diet for day %t
%^{Weight}p
"
         :prepend t :empty-lines 1)
        ("b" "Blood pressure" table-line
         (file+headline "~/org/bpressure.org" "Blood pressure table")
         "| %U | %^{systolic} | %^{diastolic} | %^{pulse} | %^{note} |")
        ("n" "Note" entry
         (file+headline "~/org/notes.org" "General Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a\n"
         :prepend t :empty-lines 1)
        ("i" "Idea" entry
         (file+headline "~/org/ideas.org" "")
         "* %^{Title}\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("p" "Purchase wishlist" entry
         (file+headline "~/org/consumerism.org" "Stuff to buy")
         "* TODO %^{Title}\n\n%?\n" :prepend t :empty-lines 1)
        ;; ("c" "CC work-related items")
        ;; ("ct" "CC Todo" entry
        ;;  (file+headline "~/org/ccommons.org" "Various Tasks")
        ;;  "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ;; ("ce" "CC Event" entry
        ;;  (file+headline "~/org/ccommons.org" "Events")
        ;;  "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ;; ("cn" "CC Note" entry
        ;;  (file+headline "~/org/ccommons.org" "Various Notes")
        ;;  "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
        ;;  :prepend t :empty-lines 1)
        ;; ("cb" "CC Billable" entry
        ;;  (file+headline "~/org/ccommons.org" "Billable Stuff")
        ;;  "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
        ;;  :prepend t :empty-lines 1)
        ("m" "MediaGoblin items")
        ("mt" "MediaGoblin TODO")
        ("mth" "MediaGoblin Todo: Hacking" entry
         (file+headline "~/org/mediagoblin.org" "Hacking Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("mtc" "MediaGoblin Todo: Community" entry
         (file+headline "~/org/mediagoblin.org" "Community Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("mta" "MediaGoblin Todo: Administration" entry
         (file+headline "~/org/mediagoblin.org" "Administrative Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("mtv" "MediaGoblin Todo: Various" entry
         (file+headline "~/org/mediagoblin.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("mtr" "MediaGoblin Todo: Review Queue" entry
         (file+headline "~/org/mediagoblin.org" "Review Queue")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("me" "MediaGoblin Event" entry
         (file+headline "~/org/mediagoblin.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("mn" "MediaGoblin Note" entry
         (file+headline "~/org/mediagoblin.org" "General Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a\n"
         :prepend t :empty-lines 1)
        ;; Digital Bazaar stuff
        ;; --------------------
        ("d" "Digital Bazaar")
        ("dt" "Digital Bazaar Various Tasks" entry
         (file+headline "~/org/contracting/dbazaar.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("dp" "Digital Bazaar Projects")
        ("dpo" "DB Projects: ocap-ld" entry
         (file+headline "~/org/contracting/dbazaar.org" "ocap-ld")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("dpc" "DB Projects: House Clerk" entry
         (file+olp "~/org/contracting/dbazaar.org"
                   "Projects" "Legislative data modeling")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ;; Contracting stuff
        ;; -----------------
        ("c" "Contracting")
        ;; General
        ("cg" "Contracting general")
        ("cgb" "Billing" entry
         (file+headline "~/org/contracting/contracting.org" "Billing")
         "* TODO Billing for %?
** TODO Get out invoice
*** TODO Write it up
*** TODO Send it in

** TODO Get paid
** TODO Record in [[file:~/org/finances.ldgr][ledger]] and [[~/org/finances.org][finances.org]]
"
         :prepend t :empty-lines 1)
        ;; Open Tech Strategies
        ("cgt" "Contracting general TODO" entry
         (file+headline "~/org/contracting/contracting.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("co" "Open Tech Strategies")
        ("cot" "OTS Todo" entry
         (file+headline "~/org/contracting/opentechstrategies.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("coe" "OTS Event" entry
         (file+headline "~/org/contracting/opentechstrategies.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("con" "OTS Note" entry
         (file+headline "~/org/contracting/opentechstrategies.org" "Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a\n"
         :prepend t :empty-lines 1)
        ("cob" "OTS Billing" entry
         (file+headline "~/org/contracting/opentechstrategies.org" "Billing")
         "* TODO Billing for %?
** TODO Get out invoice
*** TODO Write it up
*** TODO Send it in

** TODO Get paid
** TODO Record in [[file:~/org/finances.ldgr][ledger]] and [[~/org/finances.org][finances.org]]
"
         :prepend t :empty-lines 1)

  ;;       ("ml" "MediaGoblin Ledger" plain
  ;;        (file "~/records/mgllc_accounts/mediagoblin.ldgr")
  ;;        "%(org-read-date) %^{Payee}
  ;;   Expenses:%^{Account}  %^{Amount}
  ;;   Assets:Banking:Checking
  ;; ")
        ("C" "Contact" entry
         (file+headline "~/org/contacts.org" "General")
         "* %(org-contacts-template-name)
  :PROPERTIES:
  :EMAIL: %^{Email}
  :CreationTime:  %U
  :END:
%?")
        ("l" "Libre Lounge")
        ("lt" "Libre Lounge TODO" entry
         (file+headline "~/org/librelounge.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("le" "Libre Lounge Event" entry
         (file+headline "~/org/life.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ;; ("l" "Ledger entries")
        ;;       ("le" "Expense (checking)" plain
        ;;        (file "~/org/finances.ldgr")
        ;;        "%(org-read-date) %^{Payee}
        ;;   Expenses:%^{Account}  %^{Amount}
        ;;   Assets:Banking:Checking
        ;; ")
        ;;       ("lc" "Cash expense" plain
        ;;        (file "~/org/finances.ldgr")
        ;;        "%(org-read-date) %^{Payee}
        ;;   Expenses:%^{Account}  %^{Amount}
        ;;   Expenses:Cash
        ;; ")
        ;;       ("x" "XUDD")
        ;;       ("xt" "XUDD Todo" entry
        ;;        (file+headline "~/org/xudd.org" "Tasks")
        ;;        "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ;;       ("xn" "XUDD Note" entry
        ;;        (file+headline "~/org/xudd.org" "Notes")
        ;;        "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("s" "SocialWG tasks")
        ("sT" "SocialWG TODO" entry
         (file+headline "~/org/socialwg.org" "SocialWG Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("sp" "ActiviPy (Python) Todo" entry
         (file+headline "~/org/socialwg.org" "ActiviPy Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("sg" "Activitystuff (Guile) Todo" entry
         (file+headline "~/org/socialwg.org" "Activitystuff Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("r" "SpRitely tasks")
        ("rt" "Spritely Various Tasks" entry
         (file+headline "~/org/spritely.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("rg" "Goblins Tasks" entry
         (file+headline "~/org/spritely.org" "Goblins tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("rd" "Datashards Tasks" entry
         (file+headline "~/org/spritely.org" "Datashards")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("g" "Guile/Guix tasks")
        ("gt" "Guile Todo" entry
         (file+headline "~/org/guile.org" "Guile Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)
        ("gx" "Guix Todo" entry
         (file+headline "~/org/guile.org" "Guix Tasks")
         "* TODO %?\n  %i\n  %a\n" :prepend t :empty-lines 1)))

(setq org-columns-default-format "%30ITEM %TODO %DEADLINE %TAGS")

; Always file things at the start of a tree rather than at the end
(setq org-reverse-note-order t)

(setq org-log-state-notes-into-drawer t)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 8))))
(setq org-refile-use-outline-path 'file)
;; Don't take forever to refile
(setq org-refile-use-cache t)

; Force task blocking (ie, block marking as done with subtasks open)
(setq org-enforce-todo-dependencies t)
; ... but don't grey it out
(setq org-agenda-dim-blocked-tasks nil)

(defun cwebber/is-habit-p ()
  (equal (org-entry-get (point) "STYLE") "habit"))

(defun cwebber/skip-unless-habit ()
  "Checks to see if the style at point is \"habit\""
  (if (not (cwebber/is-habit-p))
      ; Skip till the next heading
      (progn (outline-next-heading) (1- (point)))))

;;;; HACK
(defun cwebber/skip-if-habit ()
  "Checks to see if the style at point is \"habit\""
  (if (cwebber/is-habit-p)
      ; Skip till the next heading
      (progn (outline-next-heading) (1- (point)))))

;; Custom agenda dispatch commands which allow you to look at
;; priorities while still being able to see when deadlines, appointments
;; are coming up.  Very often you'll just be looking at the A or B tasks,
;; and when you clear off enough of those or have some time you might
;; look also at the C tasks
;;
;; Hit "C-c a" then one of the following key sequences...
;;  - a for the A priority items, plus the agenda below it
;;  - b for A-B priority items, plus the agenda below it
;;  - c for A-C priority items, plus the agenda below it
;;  - A for just the agenda
;;  - t for just the A-C priority TODOs
(setq org-agenda-custom-commands
      '(("N" todo "NEXT")
        ("h" "Habits"
         ((agenda
           ""
           ((org-habit-show-all-today t)
            (org-agenda-skip-function 'cwebber/skip-unless-habit)
            ))))
        ;;("a" "Agenda plus plus"
        ;; ((todo "NEXT")
        ;;  (agenda "")))
        ("a" "Agenda plus A items"
         ((tags-todo
           "+PRIORITY=\"A\""
           ((org-agenda-sorting-strategy '(priority-down))))
          (agenda "")))
        ("b" "Agenda plus A+B items"
         ((tags-todo
           "+PRIORITY=\"A\"|+PRIORITY=\"B\""
           ((org-agenda-sorting-strategy '(priority-down))))
          (agenda "")))
        ("c" "Agenda plus A+B+C items"
         ((tags-todo
           "+PRIORITY=\"A\"|+PRIORITY=\"B\"|+PRIORITY=\"C\""
           ((org-agenda-sorting-strategy '(priority-down))))
          (agenda "")))
        ("d" "Agenda plus A+B+C+D items"
         ((tags-todo
           "+PRIORITY=\"A\"|+PRIORITY=\"B\"|+PRIORITY=\"C\"|+PRIORITY=\"D\""
           ((org-agenda-sorting-strategy '(priority-down))))
          (agenda "")))
        ("A" "Agenda"
         ((agenda "")))
        ("t" "Just TODO items"
         ((tags-todo
           "+PRIORITY=\"A\"|+PRIORITY=\"B\"|+PRIORITY=\"C\""
           ((org-agenda-sorting-strategy '(priority-down))))))))

; Make sure we don't block repeating tasks
(defadvice org-block-todo-from-children-or-siblings-or-parent
  (around cwebber/dont-block-if-repeating)
  "Never block if this is a repeating task"
  (let ((org-enforce-todo-dependencies
         (not (org-get-repeat))))
      ad-do-it))

(ad-activate 'org-block-todo-from-children-or-siblings-or-parent)

; It's just too hard to deal with daily repeating tasks (octavia)
; if you see them every day in the future
; I am not confident this is the right option though.
(setq org-agenda-repeating-timestamp-show-all nil)

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


;; NEXT tag on TODO magic

(defun cwebber/org-possibly-toggle-next-tag-based-on-todo-kewyord ()
  (save-excursion
    (org-back-to-heading)
    (let ((todo-is-next (equal (org-get-todo-state) "NEXT"))
          (next-in-tags (member "NEXT" (org-get-tags))))
      (if (or (and todo-is-next (not next-in-tags))
              (and (not todo-is-next) next-in-tags))
          (org-toggle-tag "NEXT")))))

(add-hook 'org-after-todo-state-change-hook
          'cwebber/org-possibly-toggle-next-tag-based-on-todo-kewyord)

;; VOODOO MAGIC

(setq cwebber/org-currently-in-NEXT-setting nil)

(defun cwebber/org-repeating-tasks-with-NEXT ()
  "Repeating entries set to NEXT should switch back to their old state when done

When first setting to NEXT, it sets a property, ORIG-TODO-STATE
If set to NEXT and it's being run again, it sets it back

This uses DARK VOODOO MAGIC but it works"
  (let ((is-repeater (org-get-repeat))
        (orig-todo-state (org-entry-get (point) "ORIG_TODO_STATE")))
    (if is-repeater
        (cond (cwebber/org-currently-in-NEXT-setting nil)  ; don't recurse :)
              ;; New state is NEXT, old state was something else
              ((and (equal org-state "NEXT")
                    (not orig-todo-state))
               (org-entry-put (point) "ORIG_TODO_STATE" org-last-state))
              ((and (equal org-state "NEXT")
                    orig-todo-state)
               (progn
                 (org-entry-delete (point) "ORIG_TODO_STATE")
                 (let ((cwebber/org-currently-in-NEXT-setting t))
                   (org-todo orig-todo-state))))))))

(add-hook 'org-after-todo-state-change-hook
          'cwebber/org-repeating-tasks-with-NEXT)


;; -----------------
;; Appointment stuff
;; -----------------

(defun cwebber/org-reset-appts ()
  "For use on grumps only... this also reverts all files, but it does update the appt list"
  (interactive)
  (setq appt-time-msg-list nil)
  (flet ((yes-or-no-p (x) t))
    (org-revert-all-org-buffers))
  (org-agenda-to-appt))

(appt-activate)
(org-agenda-to-appt)
(require 'midnight)
(setq midnight-mode t)
(remove-hook 'midnight-hook 'clean-buffer-list)
(add-hook 'midnight-hook 'org-agenda-to-appt)

;; ; This one is kinda annoying...
;; (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)

;(setq org-clock-idle-time 15)
(setq org-clock-idle-time nil)
(setq org-clock-out-remove-zero-time-clocks nil) ;; turns out I hate this feature

(setq org-agenda-clockreport-parameter-plist
      (quote (:link nil :maxlevel 5 :fileskip0 t :compact t :narrow 90 :tags "-nonbillable")))

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; -----------
;; Babel stuff
;; -----------

(require 'ob-python)
;; (require 'ob-sh)
(require 'ob-gnuplot)
(require 'ob-calc)

; Don't prompt me all the time about evaluating code blocks

(setq org-confirm-babel-evaluate nil)

(setq org-src-preserve-indentation nil)

;; -----------
;; Other stuff
;; -----------

;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(defun cwebber/set-back-open-line ()
  (define-key org-mode-map (kbd "C-o") 'open-line))

(add-hook 'org-mode-hook 'cwebber/set-back-open-line)

; More desparate
(defun org-open-line (n)
  (interactive "*p")
  (open-line n))

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

(defun cwebber/org-diet-copy-weight-to-dustycloud ()
  (interactive)
  (save-excursion
    (let ((org-diet-open-in-browser-after-export nil))
      (org-diet-expand-and-export-progress-template))
    (shell-command "scp /tmp/org_diet_results.html /tmp/weight.png /tmp/weight_month.png /tmp/weight_year.png dustycloud:/srv/dustycloud/static/tmp/")
    (browse-url "https://dustycloud.org/tmp/org_diet_results.html")
    (kill-buffer)
    (other-window -1)))

(define-key global-map (kbd "C-c o W") 'cwebber/org-diet-copy-weight-to-dustycloud)


; Open files with the programs I want.

(setq org-file-apps
      '((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "firefox %s")
        ("\\.pdf\\'" . "evince %s")))

; pretty latex source blocks!
; hm, what to do in the new exporter?

;; (setq org-export-latex-listings 'minted)
;; (setq org-latex-to-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; (add-to-list 'org-export-latex-packages-alist
;;              '("" "minted"))
;; (add-to-list 'org-export-latex-packages-alist
;;              '("" "hyperref"))

; Also in latex, @alert@
;;; Not working... why?
;; (add-to-list 'org-export-latex-emphasis-alist
;;              '("@" "\\alert{%s}" nil))

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


(defun cwebber/org-tree-to-indirect-buffer-renamed (subname)
  "Like org-tree-to-indirect-buffer, with the option to give a \"subname\""
  (interactive "sNew buffer subname?: ")
  (let ((orig-buffer-name (buffer-name (current-buffer))))
    (org-tree-to-indirect-buffer)
    (other-window 1)
    (if (not (equal subname ""))
        (rename-buffer (format "%s(%s)" orig-buffer-name subname)))))

(define-key org-mode-map (kbd "C-c C-x b") 'cwebber/org-tree-to-indirect-buffer-renamed)


;; --------------------
;; Appointment property
;; --------------------

(defun cwebber-org-add-appointment ()
  (interactive)
  (org-set-property
   "APPOINTMENT" 
   (concat "<" (org-read-date t) ">")))

;; ------------
;; org-contacts
;; ------------

;(require 'org-contacts)
;(setq org-contacts-files '("~/org/contacts.org"))
;(org-contacts-gnus-insinuate)


;; -----------------
;; Smarter archiving
;; -----------------

(setq org-archive-default-command 'org-archive-subtree)

(defun cwebber/org-archive-subtree-depending-on-property ()
  "Conditionally archive the subtree to a file or archive sibling
If the parent subtree has an ARCHIVE property, archive to a file.
Otherwise, archive to an archive sibling."
  (interactive)
  (let* ((current-level (org-current-level))
         (parent-archive-property
          (if current-level
              (save-excursion
                (org-up-heading-safe)
                (org-entry-get (point) "ARCHIVE")))))
    (cond
     ; If there is no current level, do nothing
     ((not current-level) nil)
     ; If we're at the first level, subtree archive it
     ((or (eq current-level 1)
          (not parent-archive-property))
      (let ((org-archive-default-command 'org-archive-to-archive-sibling))
        (org-archive-subtree-default-with-confirmation)))
     ; Otherwise, archive to a file
     (t
       (let ((org-archive-default-command 'org-archive-subtree))
         (org-archive-subtree-default-with-confirmation))))))

(define-key org-mode-map "\C-c\C-xA" 'cwebber/org-archive-subtree-depending-on-property)
(define-key org-mode-map "\C-c\C-xa" 'cwebber/org-archive-subtree-depending-on-property)
(define-key org-mode-map "\C-c\C-x\C-a" 'cwebber/org-archive-subtree-depending-on-property)
(define-key org-mode-map "\C-c\C-x\C-s" 'cwebber/org-archive-subtree-depending-on-property)
(define-key org-mode-map "\C-c$" 'cwebber/org-archive-subtree-depending-on-property)

;; I don't want a bookmark every time I capture things
(setq org-capture-bookmark nil)

;; I hate that foo_bar becomes foo(subscript:bar) stuff
(setq org-use-sub-superscripts '{})

;;; org tree-slide

(require 'org-tree-slide)
(define-key org-mode-map (kbd "<f6>") 'org-tree-slide-mode)
(define-key org-mode-map (kbd "S-<f6>") 'org-tree-slide-skip-done-toggle)
