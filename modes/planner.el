;;; ------
;;; Planner
;;; ------

(require 'planner)
(define-key mode-specific-map [?n] 'planner-goto-today)
(global-set-key (kbd "<f9> t") 'planner-create-task)
(global-set-key (kbd "<f9> n") 'planner-create-note)
(setq mark-diary-entries-in-calendar t)
(setq planner-project "WikiPlanner")

(setq planner-day-page-template
      "* Tasks\n\n\n* Schedule\n\n\n* Diet\n(See [[Recipes]] and [[Exercises]])\nWeigh-in: \n\n* Notes\n\n")

(require 'planner-diary)

(planner-diary-insinuate)
(add-hook 'diary-display-hook 'fancy-diary-display)

;(require 'planner-timeclock)
;(require 'planner-deadline)
;(require 'planner-schedule)
(require 'planner-cyclic)

;; Notes from Sacha
;;;;;;;;;;;;;;;;;;;
;; I've bound sacha/planner-what-am-i-supposed-to-be-doing to F9 F9. I
;; start out by clocking into the task (use planner-timeclock.el and
;; C-c TAB to mark a task as in progress). Then, when I find myself
;; getting distracted, I hit F9 F9 to see my current task in the
;; minibuffer. C-u F9 F9 jumps back to the task so that I can either
;; mark it as postponed. M-x planner-task-pending (bound to C-c C-p in
;; my local config) and M-x planner-task-done (C-c C-x) both clock out
;; of the task. If I want to jump back to the previous window
;; configuration from that planner page, I can just hit F9 F9 again.

(defvar sacha/window-register "w"
  "Register for jumping back and forth between planner and wherever I am.")
(defvar sacha/planner-current-task nil
  "Current task info.")
(defadvice planner-task-in-progress (after sacha activate)
  "Keep track of the task info."
  (setq sacha/planner-current-task (planner-current-task-info)))

(defun sacha/planner-what-am-i-supposed-to-be-doing (&optional prefix)
  "Make it easy to keep track of what I'm supposed to be working on.
If PREFIX is non-nil, jump to the current task, else display it
in a message. If called from the plan page, jump back to whatever
I was looking at."
  (interactive "P")
  (if planner-timeclock-current-task
      (if (string= (planner-task-page sacha/planner-current-task)
                   (planner-page-name))
          (jump-to-register sacha/window-register)
        (if (null prefix)
            (message "%s" planner-timeclock-current-task)
          (frame-configuration-to-register sacha/window-register)
          (planner-find-file (planner-task-page sacha/planner-current-task))
          (planner-find-task sacha/planner-current-task)))
    (if prefix
        (planner-goto-today)
      (message "No current task. HEY!"))))

(global-set-key (kbd "<f9> <f9>") 'sacha/planner-what-am-i-supposed-to-be-doing)
(defadvice planner-create-task-from-buffer (before cwebber activate)
  "Change the priority if specified.
You can set the priority of a task during creation by starting the
task description with #A, #B, or #C. This changes the default task
status."
  (when (string-match "^#\\([ABC]\\)[ \t]" title)
    (setq planner-default-task-priority (match-string 1 title))
    (setq title (substring title (match-end 0)))))
