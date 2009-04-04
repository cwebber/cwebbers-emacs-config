;;; ------
;;; Remember!
;;; ------
(require 'remember)
(require 'planner)

(require 'remember-planner)
(setq remember-handler-functions '(remember-planner-append))
(setq remember-annotation-functions planner-annotation-functions)
; (load "~/elisp/remember/remember-planner.el")
(autoload 'remember "remember" nil t)
(autoload 'remember-region "remember" nil t)
(autoload 'remember-to-planner "remember" nil t)
;; (global-set-key (kbd "<f8> <f8>") 'remember)
;; (global-set-key (kbd "<f8> r") 'remember-region)
;; (global-set-key (kbd "<f8> p") 'remember-to-planner)

;;; (From Sacha)
;; (global-set-key (kbd "<f9> <f9>") 'sacha/planner-what-am-i-supposed-to-be-doing)
;; (global-set-key (kbd "<f9> p SPC") 'planner-goto-today)
;; (global-set-key (kbd "<f9> P SPC") 'planner-goto)
;(global-set-key (kbd "<f9> r SPC") 'remember)
;(global-set-key (kbd "<f9> R SPC") 'remember-region)
;; (global-set-key (kbd "<f9> t SPC") 'planner-create-task-from-buffer)
;; (global-set-key (kbd "<f9> T SPC") 'planner-create-task)

(defadvice planner-create-task-from-buffer (before cwebber activate)
  "Change the priority if specified.
You can set the priority of a task during creation by starting the
task description with #A, #B, or #C. This changes the default task
status."
  (when (string-match "^#\\([ABC]\\)[ \t]" title)
    (setq planner-default-task-priority (match-string 1 title))
    (setq title (substring title (match-end 0)))))
