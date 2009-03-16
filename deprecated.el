;; ------
;; Initialize some things
;; ------

;; This was for the template system, which we currently aren't using
(add-to-list 'load-path "~/elisp/path")
(template-initialize)

;; npost setup
(load "~/code/elisp/newspost.el")
(setq npost-author "chris")
(setq npost-dir-local "~/sites/lingo/posts/")
(setq npost-dir-remote "/ftp:lingo@lingocomic.com:public_html/posts/")
;(global-set-key (kbd "C-c n") 'npost-new)


;; ---------
;; mmm-mode
;; ---------

(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
;; (set-face-background 'mmm-output-submode-face  "White")
(set-face-background 'mmm-code-submode-face  "cornsilk")
;; (set-face-background 'mmm-comment-submode-face "DarkOliveGreen")
(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                 ("<%=" . mmm-output-submode-face)
                 ("<%"  . mmm-code-submode-face))
    :front "<%[#=]?" 
    :back "%>" 
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
             (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
             (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))
(add-hook 'html-mode-hook
          (lambda ()
            (setq mmm-classes '(erb-code))
            (mmm-mode-on)))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
(global-set-key [f8] 'mmm-parse-buffer)


;; ---------
;; dgpg-mode
;; ---------

(require 'dgpg)
(setq dgpg-program "/usr/bin/gpg")

;; the primary recipient (used for the --recipient gpg argument)
(setq dgpg-user-id "cwebber@dustycloud.org")

;; this list is for the autocompletion when asked which key to use
(setq dgpg-recipients
      (list dgpg-user-id
	    "cwebber@dustycloud.org"))

;; ---------
;; EMMS!
;; ---------

(add-to-list 'load-path "~/elisp/emms/")
(require 'emms)
(require 'emms-player-simple)
(require 'emms-source-file)
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123<
                         emms-player-mplayer)
      emms-source-list '((emms-directory-tree "~/music/")))


;; ---------
;; Misc
;; ---------

;; Open symbolically linked files as read-only
(defun read-only-if-symlink ()
  (if (file-symlink-p buffer-file-name)
      ;progn here to execute both as part of else statement together
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink"))))

(add-hook 'find-file-hooks 'read-only-if-symlink)


;; ---------
;; Game hack
;; ---------

(require 'gamegrid)

;; (defconst gamegrid-xpm "\
;; /* XPM */
;; static char *noname[] = {
;; /* width height ncolors chars_per_pixel */
;; \"16 16 3 1\",
;; /* colors */
;; \"+ s col1\",
;; \". s col2\",
;; \"- s col3\",
;; /* pixels */
;; \"---------------+\",
;; \"--------------++\",
;; \"--............++\",
;; \"--............++\",
;; \"--............++\",
;; \"--............++\",
;; \"--...--...--..++\",
;; \"--...-+...-+..++\",
;; \"--............++\",
;; \"--.--......--.++\",
;; \"--.-+......-+.++\",
;; \"--..+------+..++\",
;; \"--...-++++++..++\",
;; \"--............++\",
;; \"-+++++++++++++++\",
;; \"++++++++++++++++\"
;; };
;; "
;;   "XPM format image used for each square")


(defconst gamegrid-xpm "\
/* XPM */
static char *noname[] = {
/* width height ncolors chars_per_pixel */
\"16 16 3 1\",
/* colors */
\"+ s col1\",
\". s col2\",
\"- s col3\",
/* pixels */
\"---------------+\",
\"--------------++\",
\"--............++\",
\"--...----.....++\",
\"--...-+++-....++\",
\"--..-+...-+...++\",
\"--..-+...-+...++\",
\"--......-+....++\",
\"--.....-+.....++\",
\"--.....-+.....++\",
\"--............++\",
\"--.....--.....++\",
\"--.....-+.....++\",
\"--............++\",
\"-+++++++++++++++\",
\"++++++++++++++++\"
};
"
  "XPM format image used for each square")


;; ---------
;; Tags stuff
;; ---------

(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (eshell-command 
   (format "find %s -iregex '*\.\(c\|h\|cpp\)' | etags -" dir-name)))


;; Python print line keyboard macro
(fset 'python\ print\ line
   (lambda (&optional arg)
     "Keyboard macro."
     (interactive "p")
     (kmacro-exec-ring-item
      (quote ([134217837 112 114 105 110 116 32 34
                         67108896 5 134217847 58 33554464
                         37 114 37 34 33554464 37 32 25] 0 "%d"))
      arg)))

;; Fo schemin' in other buffers (reading manuals)
(setq read-scheme nil)
(if read-scheme
    (progn
      (define-key Info-mode-map (kbd "M-C-x") 'scheme-send-definition) ;gnu convention
      (define-key Info-mode-map (kbd "C-x C-e") 'scheme-send-last-sexp) ;gnu convention
      (define-key Info-mode-map (kbd "C-c C-e") 'scheme-send-definition)
      (define-key Info-mode-map (kbd "C-c M-e") 'scheme-send-definition-and-go)
      (define-key Info-mode-map (kbd "C-c C-r") 'scheme-send-region)
      (define-key Info-mode-map (kbd "C-c M-r") 'scheme-send-region-and-go)
      (define-key Info-mode-map (kbd "C-c M-c") 'scheme-compile-definition)
      (define-key Info-mode-map (kbd "C-c C-c") 'scheme-compile-definition-and-go)
      (define-key Info-mode-map (kbd "C-c C-z") 'switch-to-scheme)
      (define-key Info-mode-map (kbd "C-c C-l") 'scheme-load-file)
      (define-key Info-mode-map (kbd "C-c C-k") 'scheme-compile-file))) ;k for "kompile"


;(plan)

;; ---------
;; Ido
;; ---------

; Ido, I wish I could get you to work :\
(define-key ctl-x-map "b" 'ido-switch-buffer)
