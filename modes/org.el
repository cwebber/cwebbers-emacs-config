;; --------
;; Org mode
;; --------

(require 'org)
(require 'org-id)
(require 'org-install)

; Load stuff from http://doc.norang.ca/org-mode.html
(load-file "~/.config/emacs/modes/org-norang.el")

(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)
(setq org-export-babel-evaluate nil)
(setq org-agenda-files "~/org/orgfiles.txt")
(setq org-id-track-globally nil)
(setq org-link-to-org-use-id nil)
;(setq org-id-locations-file "~/org/org-id-locations.txt")
;(setq org-agenda-include-diary t)
(setq org-agenda-timegrid-use-ampm t)
(setq org-agenda-include-diary nil)
(setq org-hide-leading-stars t)
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
        (sequence "PAYMENT-WAITING" "|" "PAID")))

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

; Priorities??

(setq org-priority-faces
      '((?A . "#f01a0f")
        (?B . "#f0640f")
        (?C . "light sea green")
        (?D . "slate blue")))

(setq org-default-priority ?C)
(setq org-lowest-priority ?D)


(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)
(setq org-habit-show-done-always-green t)

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
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("j" "Journal" entry
         (file+headline "~/org/journal.org" "")
         "* %U %?\n\n  %i\n  %a" :prepend t :empty-lines 1)
        ("w" "Weigh-in" entry
         (file+headline "~/org/diet.org" "Daily Logs")
         "* CAL-IN Diet for day %t\n%^{Weight}p\n| Food / Exercise | Calories | Quantity | Total |\n|-----------------+----------+----------+-------|\n| %?                |          |          |       |\n|-----------------+----------+----------+-------|\n| Total           |          |          |       |\n#+TBLFM: $4=$2*$3;%.0f::$LR4=vsum(@2$4..@-I$4)\n\n"
         :prepend t :empty-lines 1)
        ("b" "Blood pressure" table-line
         (file+headline "~/org/bpressure.org" "Blood pressure table")
         "| %U | %^{systolic} | %^{diastolic} | %^{pulse} | %^{note} |")
        ("n" "Note" entry
         (file+headline "~/org/notes.org" "General Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
         :prepend t :empty-lines 1)
        ("i" "Idea" entry
         (file+headline "~/org/ideas.org" "")
         "* %^{Title}\n  %i\n  %a" :prepend t :empty-lines 1)
        ("p" "Purchase wishlist" entry
         (file+headline "~/org/consumerism.org" "Stuff to buy")
         "* TODO %^{Title}\n\n%?\n" :prepend t :empty-lines 1)
        ("c" "CC work-related items")
        ("ct" "CC Todo" entry
         (file+headline "~/org/ccommons.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("ce" "CC Event" entry
         (file+headline "~/org/ccommons.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("cn" "CC Note" entry
         (file+headline "~/org/ccommons.org" "Various Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
         :prepend t :empty-lines 1)
        ("cb" "CC Billable" entry
         (file+headline "~/org/ccommons.org" "Billable Stuff")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
         :prepend t :empty-lines 1)
        ("m" "MediaGoblin items")
        ("mt" "MediaGoblin TODO")
        ("mth" "MediaGoblin Todo: Hacking" entry
         (file+headline "~/org/mediagoblin.org" "Hacking Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("mtc" "MediaGoblin Todo: Community" entry
         (file+headline "~/org/mediagoblin.org" "Community Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("mta" "MediaGoblin Todo: Administration" entry
         (file+headline "~/org/mediagoblin.org" "Administrative Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("mtv" "MediaGoblin Todo: Various" entry
         (file+headline "~/org/mediagoblin.org" "Various Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("mtr" "MediaGoblin Todo: Review Queue" entry
         (file+headline "~/org/mediagoblin.org" "Review Queue")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("me" "MediaGoblin Event" entry
         (file+headline "~/org/mediagoblin.org" "Events")
         "* %^{Event}\n   %^t\n  %i\n  %a\n\n%?" :prepend t :empty-lines 1)
        ("mn" "MediaGoblin Note" entry
         (file+headline "~/org/mediagoblin.org" "General Notes")
         "* %^{Title}\n  :PROPERTIES:\n  :CreationTime:  %U\n  :END:\n\n  %i\n\n  %a"
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
        ("l" "Ledger entries")
        ("le" "Expense (checking)" plain
         (file "~/org/finances.ldgr")
         "%(org-read-date) %^{Payee}
    Expenses:%^{Account}  %^{Amount}
    Assets:Banking:Checking
  ")
        ("lc" "Cash expense" plain
         (file "~/org/finances.ldgr")
         "%(org-read-date) %^{Payee}
    Expenses:%^{Account}  %^{Amount}
    Expenses:Cash
  ")
        ("x" "XUDD")
        ("xt" "XUDD Todo" plain
         (file+headline "~/org/xudd.org" "Tasks")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ("xn" "XUDD Note" plain
         (file+headline "~/org/xudd.org" "Notes")
         "* TODO %?\n  %i\n  %a" :prepend t :empty-lines 1)
        ))

(setq org-columns-default-format "%30ITEM %TODO %DEADLINE %TAGS")

; Always file things at the start of a tree rather than at the end
(setq org-reverse-note-order t)

(setq org-log-state-notes-into-drawer t)

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 8))))
(setq org-refile-use-outline-path 'file)

; Force task blocking (ie, block marking as done with subtasks open)
(setq org-enforce-todo-dependencies t)
; ... but don't grey it out
(setq org-agenda-dim-blocked-tasks nil)

(defun cwebber/skip-unless-habit ()
  "Checks to see if the style at point is \"habit\""
  (if (not (equal (org-entry-get (point) "STYLE") "habit"))
      ; Skip till the next heading
      (progn (outline-next-heading) (1- (point)))))

(setq org-agenda-custom-commands
      '(("N" todo "NEXT")
        ("h" "Habits"
         ((agenda
           ""
           ((org-habit-show-all-today t)
            (org-agenda-skip-function 'cwebber/skip-unless-habit)))))
        ("a" "Agenda plus plus"
         ((todo "NEXT")
          (agenda "" nil)))))

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
               (org-todo orig-todo-state)))))))

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

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)

;; -----------
;; Babel stuff
;; -----------

(require 'ob-python)
(require 'ob-sh)
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
