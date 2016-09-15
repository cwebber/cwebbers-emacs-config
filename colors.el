;;; Color theme setup, with cycling
;;; -----

(add-to-list 'load-path "~/devel/naquadah-theme/")
;; (require 'color-theme)
;; (load-file "~/elisp/color-theme-6.6.0/themes/color-theme-library.el")

;(setq color-theme-is-cumulative nil)

(defun color-theme-ebony-gnome ()
  "`color-theme-gnome2' with a black background and a nice gray
font."
  (interactive)
  (color-theme-gnome2)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-ebony-gnome
       ((foreground-color . "lightgray")
        (background-color . "black"))))))

(defun color-theme-emacs-21-black ()
  "`color-theme-emacs-21' with a black background and a nice gray
font."
  (interactive)
  (color-theme-emacs-21)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-emacs-21-black
       ((foreground-color . "lightgray")
        (background-color . "black"))))))


(defun color-theme-snow-better ()
  "Because `color-theme-snow' is so awesome, except for when it
isn't."
  (interactive)
  (color-theme-snow)
  (let ((color-theme-is-cumulative t))
    (color-theme-install
     '(color-theme-snow-better
       ((background-color . "snow2")
        (background-mode . light)
        (border-color . "black")
        (cursor-color . "cadet blue")
        (foreground-color . "black")
        (mouse-color . "black"))
       (emacs-wiki-link-face ((t (:bold t :underline "BlueViolet" :foreground "BlueViolet"))))
       (muse-link-face ((t (:bold t :underline "BlueViolet" :foreground "BlueViolet"))))
       (info-xref ((t (:bold t :foreground "BlueViolet"))))
       (region ((t (:background "light steel blue"))))
       (cursor ((t (:background "cadet blue"))))
       (fringe ((t (:background "white"))))
       (planner-high-priority-task-face ((t (:foreground "red"))))
       (planner-medium-priority-task-face ((t (:foreground "green"))))
       (planner-low-priority-task-face ((t (:foreground "blue"))))
       (planner-canceled-task-face ((t (:foreground "gray" :strike-through t))))
       (org-todo ((t (:foreground "red2" :bold t))))
       (org-done ((t (:foreground "SpringGreen3" :bold t))))
       (org-special-keyword ((t (:foreground "sienna"))))
       (org-column ((t (:background "gray85"))))
;       (py-pseudo-keyword-face ((t (:foreground: 
       (erc-input-face ((t (:foreground "brown"))))
       (erc-notice-face ((t (:foreground "SlateBlue" :bold t))))
       (erc-current-nick-face ((t (:foreground "DarkTurquoise" :bold t))))
       (erc-prompt-face ((t (:foreground "Black" :bold t :background "lightBlue2"))))
       (planner-note-headline-face ((t (:bold t :foreground "azure3"))))))))


(setq my-color-themes 
      (list 'color-theme-snow-better
	    'color-theme-ebony-gnome
	    'color-theme-emacs-21-black))
;; 	    'color-theme-taming-mr-arneson 'color-theme-gray30 
;; 	    'color-theme-hober 'color-theme-clarity
;; 	    'color-theme-arjen 'color-theme-dark-laptop
;; 	    'color-theme-subtle-hacker 'color-theme-deep-blue))


(defun my-theme-set-default ()		; Set the first row
  (interactive)
  (setq theme-current my-color-themes)
  (if window-system (funcall (car theme-current))))

(defun my-describe-theme ()		; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))

(defun my-theme-cycle ()		; Set the next theme
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (my-describe-theme))

(defun my-refresh-current-theme (&optional frame)
  (interactive)
  (funcall (car theme-current)))

(defun cwebber/load-primary-theme (&optional frame)
  (interactive)
  (when window-system
    (if frame
        (select-frame frame))
    ; guess I shouldn't tack this in here, but meh...
    (set-default-font "mono-9")
    (funcall (car my-color-themes))))

(setq theme-current my-color-themes)

;(my-theme-set-default)
;(global-set-key [f12] 'my-theme-cycle)
;(global-set-key [f11] 'my-refresh-current-theme)

;(add-hook 'after-make-frame-functions 'cwebber/load-primary-theme)
;; (remove-hook 'after-make-frame-functions 'cwebber/load-primary-theme)

;; (defadvice make-frame (after possibly-load-color-theme)
;;   "Load the color theme if we are in x, but not if in a terminal"
;;   (message "Hello thar")
;;   (message ad-return-value)
;;   (cwebber/load-primary-theme))

;; (ad-activate 'make-frame)

;;;; And now, set faces
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-marker-1-face ((t (:background "red" :foreground "black")))))

(require 'naquadah-theme)
(load-theme 'naquadah t)
;; (load-theme 'wombat t)

(when (not window-system)
  (set-face-attribute 'region nil :background "blue"))

; (require 'dark-emacs-theme)

(defun cwebber/fix-font-size (&optional frame)
  (interactive)
  (when window-system
    (if frame
        (select-frame frame))
    (set-default-font "mono-10")))

; Make the ansi-term blue not so painful
(setq ansi-color-names-vector
      ["black" "red" "green" "yellow" "#729fcf"
       "magenta" "cyan" "white"])
(setq ansi-color-map (ansi-color-make-color-map))

(add-hook 'after-make-frame-functions 'cwebber/fix-font-size)
