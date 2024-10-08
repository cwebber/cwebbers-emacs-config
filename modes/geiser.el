(require 'geiser)
(require 'geiser-guile)
(setq geiser-default-implementation 'guile)
(setq geiser-active-implementations '(guile mit racket))
(setq geiser-mode-smart-tab-p t)

(defun cwebber/geiser-completion-prefs ()
  (auto-complete-mode -1)
  (company-mode 1))

(add-hook 'geiser-mode-hook 'cwebber/geiser-completion-prefs)
(add-hook 'geiser-repl-mode-hook 'cwebber/geiser-completion-prefs)

;;; This no longer works...
;; (setq geiser-guile-binary '("/home/cwebber/devel/guix/pre-inst-env" "guile"))

;; (with-eval-after-load 'geiser-guile
;;   (add-to-list 'geiser-guile-load-path "~/devel/guix"))

;; (with-eval-after-load 'geiser-guile
;;   (add-to-list 'geiser-guile-load-path "~/devel/guix")
;;   (add-to-list 'geiser-guile-load-path "~/devel/nonguix"))


(with-eval-after-load 'yasnippet
  (add-to-list 'yas-snippet-dirs "~/devel/guix/etc/snippets"))


;; a list of lists, for each of which the car being a directory that
;; has a project, the cdr is whatever other paths should also be added

(setq cwebber/guile-projects
      '(("~/devel/guile-goblins")
        ("~/devel/guix-config"
         ;; "~/devel/guix"
         "~/devel/nonguix")
        ("~/devel/guix")
        ("~/work/guile-prescheme/")
        ("~/devel/guix"
         ;; "~/devel/nonguix"
         )
        ("~/devel/brainy"
         "~/devel/guile-goblins")
        ("~/devel/spritely.institute")
        ("~/devel/guile-hoot/module")
        ("~/devel/spritely-papers"
         "~/devel/guile-goblins")
        ("~/devel/spritelyproject.org")
        ("~/devel/terminal-phase"
         "~/devel/guile-goblins"
         )
        ("~/devel/dustycloud")
        ("~/devel/fantasary"
         "~/devel/guile-goblins")
        ("~/devel/chickflix"
         "~/devel/guile-goblins")
        ("~/devel/wasm4-wireworld"
         "~/devel/guile-hoot/module")
        ("~/devel/guile-syrup")))

(defun cwebber/setup-guile-project-paths ()
  (catch 'done
    (dolist (project-info cwebber/guile-projects)
      (when (string-prefix-p (expand-file-name (car project-info))
                             (buffer-file-name))
        (make-local-variable 'geiser-guile-load-path)
        (dolist (load-path project-info)
          (cl-pushnew (expand-file-name load-path) geiser-guile-load-path
                      :test 'string-equal))
        (message (concat "Setup geiser guile load-paths for: " (car project-info)))
        (throw 'done t)))))

(add-hook 'geiser-mode-hook 'cwebber/setup-guile-project-paths)

; (let ((geiser-guile-binary '("guix" "environment" "-l" "/home/cwebber/devel/guile-goblins/guix.scm" "--" "/home/cwebber/devel/guile-goblins/pre-inst-env" "guile")))
;   (run-guile))

;; One geiser per project
;;; (setq geiser-repl-per-project-p t)
