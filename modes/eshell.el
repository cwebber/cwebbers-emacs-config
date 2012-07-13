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
  ;(make-local-hook 'window-scroll-functions)
  (add-hook 'window-scroll-functions 'eshell-scroll-to-bottom nil t))

(add-hook 'eshell-mode-hook 'eshell-add-scroll-to-bottom)

; Set the $PAGER to ""

(defun eshell-unset-pager ()
  (setenv "PAGER" ""))

(add-hook 'eshell-mode-hook 'eshell-unset-pager)

; another emacswiki borrow

;; (require 'ansi-color)
;; (defun eshell-handle-ansi-color ()
;;   (ansi-color-apply-on-region eshell-last-output-start
;;                               eshell-last-output-end))
;; (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)
