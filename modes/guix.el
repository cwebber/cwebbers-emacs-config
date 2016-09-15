;; ;; <mark_weaver> paroneayea: it's a hack, but /run/current-system will exist on a
;; ;;               GuixSD system and not on Debian.
;; ;; <mark_weaver> I hope such a test will never end up in any published software.
;; (if (not (file-exists-p "/run/current-system"))
;;     (progn
;;       (add-to-list 'load-path "/home/cwebber/devel/guix/emacs")
;;       (setq guix-load-path "/home/cwebber/devel/guix/emacs")
;;       (setq guix-guile-program
;; 	    '("/home/cwebber/devel/guix/pre-inst-env" "guile"))))

(add-to-list 'load-path "/home/cwebber/devel/guix/emacs")
(setq guix-load-path "/home/cwebber/devel/guix/emacs")
(setq guix-guile-program '("/home/cwebber/devel/guix/pre-inst-env" "guile"))

(require 'guix-init nil t)
; (guix-emacs-autoload-packages)

(global-set-key (kbd "C-c g") 'guix)
(global-set-key (kbd "C-c G p") 'guix-all-available-packages)
(global-set-key (kbd "C-c G g") 'guix-generations)
