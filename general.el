;; ------
;; Require misc stuff
;; ------
(require 'nxml-mode)
(require 'python)
(require 'ruby-mode)
(require 'epa-file)
(require 'ibuffer)
(epa-file-enable)

;; ------
;; Place backups in ~/.backups/ directory, like a civilized program.
;; ------
(if (file-directory-p "~/.backup")
    (setq backup-directory-alist '(("." . "~/.backup")))
  (message "Directory does not exist: ~/.backup"))
(setq backup-by-copying t    ; Don't delink hardlinks
      delete-old-versions t  ; Clean up the backups
      version-control t      ; Use version numbers on backups,
      kept-new-versions 3    ; keep some new versions
      kept-old-versions 2)   ; and some old ones, too
;; ---------

;; ---------
;; Make debian/ubuntu work nicely with cvs emacs
;; ---------
;; (let ((startup-file "/usr/share/emacs/site-lisp/debian-startup.el"))
;;   (if (and (or (not (fboundp 'debian-startup))
;;                (not (boundp  'debian-emacs-flavor)))
;;            (file-readable-p startup-file))
;;       (progn
;;         (load-file startup-file)
;;         (setq debian-emacs-flavor 'emacs22)
;;         (debian-startup debian-emacs-flavor)
;;         (mapcar '(lambda (f)
;;                    (and (not (string= (substring f -3) "/.."))
;;                         (file-directory-p f) 
;;                         (add-to-list 'load-path f)))
;;                 (directory-files "/usr/share/emacs/site-lisp" t)))))

;; ---------
;; Generic keybindings
;; ---------

; (please move more here soon)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-c fd") 'find-dired)
(global-set-key (kbd "C-c d") 'diff-buffer-with-file)
(global-set-key (kbd "C-c R") 'revert-buffer)

; These should be made more local when I figure out how

;; Life-hack keybindings

(global-set-key (kbd "C-c lc") 'calendar)
(global-set-key (kbd "C-c lp") 'plan)


;; ------
;; General config BS
;; ------

(setq fill-column 79)

(setq max-specpdl-size 9000)

(when (not window-system)
  ;;allow you to see the region when in console mode
  (setq transient-mark-mode t))

;; Shell stuff
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq shell-file-name "/bin/bash")
(setq explicit-shell-file-name "/bin/bash")

(setq ispell-alternate-dictionary "/etc/dictionaries-common/words")

(setq diary-file "~/org/diary")
(setq tex-dvi-view-command
          (if (eq window-system 'x) "xdvi" "dvi2tty * | cat -s"))

; tab auto-completion cycling is evil.
(setq pcomplete-cycle-completions nil)

;; Make sure that pressing middle mouse button pastes right at point,
;; not where the mouse cursor is.
(setq mouse-yank-at-point t)

;; Don't show my password when I'm entering it, kthx.
(add-hook 'comint-output-filter-functions
           'comint-watch-for-password-prompt)


(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq inhibit-splash-screen t)

(setq column-number-mode 1)

(setq visual-line-fringe-indicators '(t t))

; Don't switch to another frame with iswitchb
(setq iswitchb-default-method 'samewindow)

; Use diff -u

(setq diff-switches "-u")


;; ------
;; Initialize some things
;; ------

; (display-time)
(server-start)

;; Mouse scrolling
(mwheel-install)

;; Shift-arrowkey based movement
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; ------
;; Terminal / window specific stuff
;; ------

;; Don't minimize my emacs! Honestly wtf
(when window-system
  (progn
    (global-unset-key (kbd "C-z"))
    (setq scroll-bar-mode nil)
    (tool-bar-mode nil)
    (menu-bar-mode nil)))


;; ---------
;; Custom funcs
;; ---------

(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun warn-if-symlink ()
  (if (file-symlink-p buffer-file-name)
      ;progn here to execute both as part of else statement together
      (message "File is a symlink")))

(add-hook 'find-file-hooks 'warn-if-symlink)


;; creating a scratch buffer command
(defun create-scratch-buffer nil
  "create a scratch buffer"
  (interactive)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (insert ";; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

"))


;; If the *scratch* buffer is killed, recreate it automatically
;; FROM: Morten Welind
;;http://www.geocrawler.com/archives/3/338/1994/6/0/1877802/
(save-excursion
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer))

(defun kill-scratch-buffer ()
  ;; The next line is just in case someone calls this manually
  (set-buffer (get-buffer-create "*scratch*"))
  ;; Kill the current (*scratch*) buffer
  (remove-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  (kill-buffer (current-buffer))
  ;; Make a brand new *scratch* buffer
  (set-buffer (get-buffer-create "*scratch*"))
  (lisp-interaction-mode)
  (make-local-variable 'kill-buffer-query-functions)
  (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer)
  ;; Since we killed it, don't let caller do that.
  nil)

;; Highlight previous (or current?) line
(defun pg-uline (ulinechar)
  "Underline the current or the previous line with ULINECHAR"
  (interactive "cUnderline with:")
  (if (looking-at "^$")
      (next-line -1))
  (end-of-line)  
  (let ((linelen (current-column)))
    (insert "\n")
    (while (> linelen 0)
      (setq linelen (1- linelen))
      (insert ulinechar)))
  (insert "\n"))

(global-set-key (kbd "C-c u") 'pg-uline)


;; Swapping buffers!  Can't live without this

(setq cwebber/swapping-buffer nil)
(setq cwebber/swapping-window nil)

(defun cwebber/swap-buffers-in-windows ()
  "Swap buffers between two windows"
  (interactive)
  (if (and cwebber/swapping-window
           cwebber/swapping-buffer)
      (let ((this-buffer (current-buffer))
            (this-window (selected-window)))
        (if (and (window-live-p cwebber/swapping-window)
                 (buffer-live-p cwebber/swapping-buffer))
            (progn (switch-to-buffer cwebber/swapping-buffer)
                   (select-window cwebber/swapping-window)
                   (switch-to-buffer this-buffer)
                   (select-window this-window)
                   (message "Swapped buffers."))
          (message "Old buffer/window killed.  Aborting."))
        (setq cwebber/swapping-buffer nil)
        (setq cwebber/swapping-window nil))
    (progn
      (setq cwebber/swapping-buffer (current-buffer))
      (setq cwebber/swapping-window (selected-window))
      (message "Buffer and window marked for swapping."))))

(global-set-key (kbd "C-c p") 'cwebber/swap-buffers-in-windows)


;; other stuff

(defun add-spaces-to-region (beginning end numspaces)
  "Add spaces to a whole region of text"
  (interactive "r\nnNumber of spaces: ")
  (save-excursion
    (goto-char beginning)
    (beginning-of-line)
    (while (< (point) end)
      (let ((bol-point 0)
            (eol-point 0))
        (save-excursion
          (end-of-line)
          (setq eol-point (point))
          (beginning-of-line)
          (setq bol-point (point)))
        (if (not (equal bol-point eol-point))
            (progn
              (beginning-of-line)
              (dotimes (i numspaces)
                (insert " ")))))
      (forward-line)
      (beginning-of-line))))

(defun rename-buffer-with-directory (&optional arg)
  "Useful for when you're dealing with multiple files with the
  same name in different directories.  No more file.txt<2>!

  Running this will append the previous directory to the end of
  the filename.  So for example, if you opened the emacs
  ChangeLog (living in the emacs/ directory), you'll get
  'ChangeLog(emacs/)'.  Using a prefix arg will give you number
  of subdirectories, if you need it.

  If you are accessing a file over Tramp, it will add 'host:' to
  the parenthesis.. so if you were accessing
  /ssh:example.org:/home/foobar/emacs/ChangeLog, you'd get:
  'ChangeLog(example.org:emacs/)'"
  (interactive "^p")
  (let ((dir-name nil)
        (split-path (eshell-split-path
                         (file-name-directory (buffer-file-name))))
        (tramp-data (condition-case nil
                        (tramp-dissect-file-name (buffer-file-name))
                      (error nil))))
    (setq dir-name
          (apply 'concat (nthcdr (- (length split-path) arg) split-path)))
    (rename-buffer
     (concat (file-name-nondirectory (buffer-file-name))
             (if tramp-data
               (concat
                "(" (aref tramp-data 2) ":" dir-name ")")
               (concat "(" dir-name ")"))))))


(defun insert-virtualenv-load-line (virtualenv-dir)
  (interactive "DVirtualenv directory: ")
  (let ((activate-file (expand-file-name (concat virtualenv-dir "./bin/activate_this.py"))))
    (if (file-exists-p activate-file)
        (insert
         (concat "execfile('" activate-file
                 "', dict(__file__='" activate-file "'))"))
      (error "No ./bin/activate_this.py in that virtualenv (maybe update virtualenv?)"))))
  

; (global-set-key (kbd "C-c r") 'rename-buffer-with-directory)

(defun blender-style ()
  (interactive)
  (c-set-style "bsd")
  (setq indent-tabs-mode t) 
  (setq tab-width 4)
  (setq c-basic-offset 4))


;; En1arg3 y0ur w1|\|dow!!!
(defun undo-or-shrink-horizontally ()
  "Either undo or shrink horizontally, depending on whether we're
in X or in a terminal"
  (interactive)
  (if (window-system)
      (shrink-window-horizontally)
    (undo)))

(global-set-key (kbd "C-=") 'enlarge-window)
(global-set-key (kbd "C--") 'shrink-window)
(global-set-key (kbd "C-+") 'enlarge-window-horizontally)
(global-set-key (kbd "C-_") 'undo-or-shrink-horizontally)
(global-set-key (kbd "C-c x") 'execute-extended-command)
(global-set-key [S-prior] 'beginning-of-buffer)
(global-set-key [S-next] 'end-of-buffer)


;; Apparently I'm a crufty old timer who likes the way the old mouse
;; and x11 pasting worked.  This sets it back

(global-set-key [mouse-2] 'mouse-yank-at-click)

(setq mouse-drag-copy-region t
      select-active-regions nil
      x-select-enable-primary t
      x-select-enable-clipboard nil)

;; I also like my scrollbars on the left, thanks!

(set-scroll-bar-mode 'left)

;; ----------
;; Mail stuff
;; ----------

(setq mail-source-movemail-program "/usr/bin/movemail")

; Randomly choose mail signature
(setq cwebber-mail-sigs
      '("The bottom line."
        "http://dustycloud.org/"
        "𝓒𝓱𝓻𝓲𝓼𝓽𝓸𝓹𝓱𝓮𝓻 𝓐𝓵𝓵𝓪𝓷 𝓦𝓮𝓫𝓫𝓮𝓻"))

(defun cwebber-random-mail-sig ()
  (nth (random (length cwebber-mail-sigs))
       cwebber-mail-sigs))

;(setq mail-signature 'cwebber-random-mail-sig)
;(setq message-signature 'cwebber-random-mail-sig)
(setq mail-signature nil)
(setq message-signature nil)

;; ---------
;; Load some custom stuff
;; ---------

(defun insert-ellipsis ()
  (interactive)
  (insert "…"))
(global-set-key (kbd "C-c ;") 'insert-ellipsis)

; Always compose mail with gnus.  *ALWAYS*.
(setq read-mail-command 'gnus)
(setq mail-user-agent 'gnus-user-agent)

; Turn off tool-bar-mode, which is slow
(call-interactively 'tool-bar-mode)

;; UTF-8 support
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; highlight current line
;; Kinda cool but not really needed right now
; (global-hl-line-mode +1)

; lock files borking git-annex-assistant autocommits.  Disabling for now.
;; We can re-enable both of these once .gitignore support comes to git-annex
(setq create-lockfiles nil)
; Similarly with auto-save files :(
(setq auto-save-default nil)

;; How did electric-indent-mode get turned on?  Why the hell would i want that
(setq electric-indent-mode nil)

;; Not sure where else to put this, but hey

(defun open-srfi (srfi-num)
  "Open srfi at SRFI-NUM in eww"
  (interactive "nSRFI number: ")
  (eww (concat "http://srfi.schemers.org/srfi-"
               (int-to-string srfi-num)
               "/srfi-"
               (int-to-string srfi-num) ".html")))

;; Heart-and-stars page breaks!

(defun heart-and-stars-pagebreaks ()
  "Replace that boring ^L character with a sparklebutt explosion"
  (interactive)
  (progn
    (unless buffer-display-table
      (setq buffer-display-table (make-display-table)))
    (aset buffer-display-table ?\^L
          (vconcat
           (mapcar (lambda (c)
                     (make-glyph-code c 'escape-glyph))
                   ".✯⁂♥♥♥⁂✯.")))))
