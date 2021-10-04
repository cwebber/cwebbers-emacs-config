;;; Color theme setup, with cycling
;;; -----

(add-to-list 'load-path "~/devel/naquadah-theme/")
(add-to-list 'load-path "~/devel/snowy-theme/")

(require 'snowy-theme)
(require 'naquadah-theme)
;; (load-theme 'snowy t)
(load-theme 'naquadah t)

(when (not window-system)
  (set-face-attribute 'region nil :background "blue"))

; Make the ansi-term blue not so painful
(setq ansi-color-names-vector
      ["black" "red" "green" "yellow" "#729fcf"
       "magenta" "cyan" "white"])
(setq ansi-color-map (ansi-color-make-color-map))

(defun cwebber/medium-font ()
  (interactive)
  (set-frame-font "Liberation Mono-12"))

(defun cwebber/small-font ()
  (interactive)
  (set-frame-font "Inconsolata-12"))
