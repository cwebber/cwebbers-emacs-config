;; Indentation stuff

(put 'signal-let* 'scheme-indent-function 1)
(put 'signal-let 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'extend-methods 'scheme-indent-function 1)

;;; =============
;;; From Mark Weaver. See this thread on guix-devel:
;;;   http://lists.gnu.org/archive/html/guix-devel/2016-05/msg00603.html

;; Slightly modified scheme-indent-function (starting from the one in
;; Emacs 24.2) that properly indents s-exprs starting with a keyword
;; like this:
;;
;; (#:foo 1
;;  #:bar 2)
;;
;; instead of like this:
;;
;; (#:foo 1
;;        #:bar 2)
;;
;; NOTE: These modifications are probably a bit hacky, as I was too
;; lazy to fully understand the lisp indent code, and am not very
;; familiar with elisp.

(defun scheme-indent-function (indent-point state)
  "Scheme mode function for the value of the variable `lisp-indent-function'.
This behaves like the function `lisp-indent-function', except that:

i) it checks for a non-nil value of the property `scheme-indent-function'
\(or the deprecated `scheme-indent-hook'), rather than `lisp-indent-function'.

ii) if that property specifies a function, it is called with three
arguments (not two), the third argument being the default (i.e., current)
indentation."
  (let ((normal-indent (current-column)))
    (goto-char (1+ (elt state 1)))
    (parse-partial-sexp (point) calculate-lisp-indent-last-sexp 0 t)
    (if (and (elt state 2)
             (not (looking-at "\\sw\\|\\s_")))
        ;; car of form doesn't seem to be a symbol
        (progn
          (if (not (> (save-excursion (forward-line 1) (point))
                      calculate-lisp-indent-last-sexp))
              (progn (goto-char calculate-lisp-indent-last-sexp)
                     (beginning-of-line)
                     (parse-partial-sexp (point)
					 calculate-lisp-indent-last-sexp 0 t)))
          ;; Indent under the list or under the first sexp on the same
          ;; line as calculate-lisp-indent-last-sexp.  Note that first
          ;; thing on that line has to be complete sexp since we are
          ;; inside the innermost containing sexp.
          (backward-prefix-chars)
          (current-column))
      (let ((function (buffer-substring (point)
					(progn (forward-sexp 1) (point))))
	    method)
	(setq method (or (get (intern-soft function) 'scheme-indent-function)
			 (get (intern-soft function) 'scheme-indent-hook)))
	(cond ((or (eq method 'defun)
		   (and (null method)
			(> (length function) 3)
			(string-match "\\`def" function)))
	       (lisp-indent-defform state indent-point))
              ;; This next cond clause is the only change -mhw
	      ((and (null method)
                    (> (length function) 1)
                    ; The '#' in '#:' seems to get lost, not sure why
                    (string-match "\\`:" function))
               (let ((lisp-body-indent 1))
                 (lisp-indent-defform state indent-point)))
	      ((integerp method)
	       (lisp-indent-specform method state
				     indent-point normal-indent))
	      (method
               (funcall method state indent-point normal-indent)))))))

;;; =============

;;; More robust keyword highlighting

;; (setq scheme-font-lock-keywords
;;       (list
;;        ;;
;;        ;; Declarations.  Hannes Haug <hannes.haug@student.uni-tuebingen.de> says
;;        ;; this works for SOS, STklos, SCOOPS, Meroon and Tiny CLOS.
;;        (list (concat "(\\(define\\("
;;                      ;; Function names.
;;                      "\\(\\|-public\\|-method\\|-generic\\(-procedure\\)?\\)\\|"
;;                      ;; Macro names, as variable names.  A bit dubious, this.
;;                      "\\(-syntax\\|-macro\\)\\|"
;;                      ;; Class names.
;;                      "-class"
;;                      ;; Guile modules.
;;                      "\\|-module"
;;                      "\\)\\*?\\)\\>"
;;                      ;; Any whitespace and declared object.
;;                      ;; The "(*" is for curried definitions, e.g.,
;;                      ;;  (define ((sum a) b) (+ a b))
;;                      "[ \t]*(*"
;;                      "\\(\\sw+\\)?")
;;              '(1 font-lock-keyword-face)
;;              '(6 (cond ((match-beginning 3) font-lock-function-name-face)
;;                        ((match-beginning 5) font-lock-variable-name-face)
;;                        (t font-lock-type-face))
;;                  nil t))
;;        ))


;;; This is for 8sync!

(put 'mbody-receive 'scheme-indent-function 2)

;;; Hacking on a particular project?  Hm hm!
(defvar guile-projects
  '((goblins "~/devel/guile-goblins")
    (syrup "~/devel/syrup/impls/guile")
    (spritely.institute-site "~/devel/spritely.institute-site")
    ;; (guile "~/devel/guile")
    ))

(require 'cl-lib)

(defun guile-projectify (project-name)
  (interactive (list (completing-read "Project: "
                                      (mapcar
                                       (lambda (x) (symbol-name (car x)))
                                       guile-projects))))
  (let ((project-dir (cadr (assoc (intern project-name)
                                  guile-projects))))
    (cond
     ((not project-dir)
      (message "No such project...?"))
     (t
      (make-local-variable 'geiser-guile-load-path)
      (cl-pushnew project-dir geiser-guile-load-path
                  :test 'string-equal)))))


;; Some propagators stuff
(put 'p:when 'scheme-indent-function 1)
(put 'e:when 'scheme-indent-function 1)
(put 'p:unless 'scheme-indent-function 1)
(put 'e:unless 'scheme-indent-function 1)
