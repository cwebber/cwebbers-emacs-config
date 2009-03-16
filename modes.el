;; --------
;; Org mode
;; --------

(setq load-path (cons "~/elisp/org-mode/lisp" load-path))
(require 'org)
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)

(setq org-export-html-toplevel-hlevel 2)


;; --------
;; Mozrepl
;; --------

(load-file "~/elisp/moz.el")
(load-file "~/elisp/javascript.el")

(require 'moz)
(require 'json)
 
(defun moz-update (&rest ignored)
  "Update the remote mozrepl instance"
  (interactive)
  (comint-send-string (inferior-moz-process)
    (concat "content.document.body.innerHTML="
             (json-encode (buffer-string)) ";")))
 
(defun moz-enable-auto-update ()
  "Automatically the remote mozrepl when this buffer changes"
  (interactive)
  (add-hook 'after-change-functions 'moz-update t t))
 
(defun moz-disable-auto-update ()
  "Disable automatic mozrepl updates"
  (interactive)
  (remove-hook 'after-change-functions 'moz-update t))

(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
(add-hook 'javascript-mode-hook 'java-custom-setup)
(defun javascript-custom-setup () (moz-minor-mode 1))


;; ---------
;; emacs-w3m
;; ---------

(setq load-path (add-to-list 'load-path "~/elisp/emacs-w3m/"))
(require 'w3m)
(setq w3m-use-cookies t)

(defun cwebber/w3m-save-link ()
  "Copy the link at point to the kill ring."
  (interactive)
  (let ((link (w3m-anchor)))
    (if link
        (kill-new link)
      (message "Point is not on a link."))))

(global-set-key (kbd "C-c k") 'cwebber/w3m-save-link)


;; ---------
;; Column-marker
;; ---------

(load "~/elisp/column-marker.el")
(add-hook 'python-mode-hook
          (lambda () (interactive) (column-marker-1 80)))


;; ---------
;; Ledger
;; ---------
(load "~/elisp/ledger.el")


;; ---------
;; Tramp
;; ---------
(require 'tramp)
(setq tramp-default-method "ssh")
(add-to-list 'tramp-default-method-alist '("localhost" "" "sudo"))
(setq tramp-backup-directory-alist backup-directory-alist)


;; ---------
;; Muse
;; ---------

;;; Muse-mode
(require 'muse)
(require 'muse-mode)  ; load authoring mode
(require 'muse-html)  ; load publishing styles I use
(require 'muse-latex)
(require 'muse-project)
;(setq muse-latex-header "./header.tex")

(setq muse-project-alist
      '(("WikiPlanner"
	 ("~/Plans"
	  :default "Taskpool"
	  :major-mode planner-mode
	  :visit-link planner-visit-link)
	 (:base "planner-xhtml"
		:path "~/Documents/planner/"))
        ("dustycloud" ; dustycloud.org stuff
	 ("~/proj/dustycloud/" :default "index")
	 (:base "xhtml" :path "~/Documents/dustycloud"))))

;; (add-to-list 'muse-publish-markup-regexps
;; 	     '(2150 "^SP{\\(.*\\)}: \\(\\(?:.\\|.\n\\)*.\\)\\(?:\n\\|\\'\\)"
;; 		    0 actor))

;; (add-to-list 'muse-publish-markup-functions
;; 	     '(actor . muse-publish-markup-actor))

;(add-hook 'muse-mode-hook 'ruler-mode)

;(require 'muse-latex)


;; ---------
;; PHP mode
;; ---------

(load "~/elisp/php-mode.el")
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php3\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.php4\\'" . php-mode))


;; ---------
;; CSS Mode
;; ---------

(load "~/elisp/css-mode.el")
(autoload 'css-mode "css-mode" "CSS editing mode" t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))


;; ---------
;; eshell
;; ---------

(setq eshell-cmpl-cycle-completions nil)

;; eshell scrolling betterness
(defun eshell-scroll-to-bottom (window display-start)
  (if (and window (window-live-p window))
      (let ((resize-mini-windows nil))
	(save-selected-window
	  (select-window window)
	  (save-restriction
	    (widen)
	    (when (> (point) eshell-last-output-start) ; we're editing a line. Scroll.
	      (save-excursion
		(recenter -1)
		(sit-for 0))))))))

(defun eshell-add-scroll-to-bottom ()
  (interactive)
  (make-local-hook 'window-scroll-functions)
  (add-hook 'window-scroll-functions 'eshell-scroll-to-bottom nil t))

(add-hook 'eshell-mode-hook 'eshell-add-scroll-to-bottom)

;;; --------
;;; Flymake / Pyflakes
;;; --------

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

(add-hook 'find-file-hook 'flymake-find-file-hook)
(remove-hook 'find-file-hook 'flymake-find-file-hook)
(load-file "~/elisp/flymake-cursor.el")

(setq flymake-allowed-file-name-masks
      '(("\\.py\\'" flymake-pyflakes-init)
        ("\\.c\\'" flymake-simple-make-init)
        ("\\.cpp\\'" flymake-simple-make-init)
        ("\\.xml\\'" flymake-xml-init)
        ;("\\.html?\\'" flymake-xml-init)
        ("\\.cs\\'" flymake-simple-make-init)
        ("\\.p[ml]\\'" flymake-perl-init)
        ("\\.php[345]?\\'" flymake-php-init)
        ("\\.h\\'" flymake-master-make-header-init flymake-master-cleanup)
        ("\\.java\\'" flymake-simple-make-java-init flymake-simple-java-cleanup)
        ("[0-9]+\\.tex\\'" flymake-master-tex-init flymake-master-cleanup)
        ("\\.tex\\'" flymake-simple-tex-init)
        ("\\.idl\\'" flymake-simple-make-init)))


;; ---------
;; ERC
;; ---------

(setq erc-nick "paroneayea")
(setq erc-user-full-name user-full-name)
;; (setq browse-url-browser-function 'w3m-browse-url)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART"
 				"QUIT" "MODE"))
(setq erc-log-channels-directory "~/.erc/logs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps t)

; automatically log conversations
(require 'erc-log)
(erc-log-mode t)
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)


;; ---------
;; LongLines
;; ---------

;; act (more) like a word processor
(load "~/elisp/longlines.el")
(add-to-list 'auto-mode-alist '("\\.ll\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.txt\\'" . text-mode))


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


;; ---------
;; BBDB
;; ---------

;; Keeping contacts the Orwell way

;; Do we really need to run the latest version?
;(setq load-path (add-to-list 'load-path "~/elisp/bbdb/lisp/"))

(require 'bbdb)
(bbdb-initialize 'gnus 'message)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(global-set-key (kbd "C-c b") 'bbdb)


;; ---------
;; Slime mode
;; ---------

(setq inferior-lisp-program "/usr/bin/sbcl")
(require 'slime)
(slime-setup)


;; ---------
;; Ledger mode
;; ---------

(setenv "LEDGER" "/home/cwebber/records/ledger.dat")
(load "~/elisp/ledger.el")

(defun my-open-my-ledger-file ()
  "Opens my usual ledger file ands sets up for ledgerin'."
  (interactive)
  (find-file "~/records/ledger.dat")
  (end-of-buffer)
  (ledger-mode))
(global-set-key (kbd "C-c fl") 'my-open-my-ledger-file)


;;; ------
;;; Magit
;;; ------

(load "~/elisp/magit/magit.el")


;; ---------
;; Word count
;; ---------

(load "~/elisp/word-counter.el")
(require 'word-counter)
(global-set-key (kbd "C-c w") 'word-count)
