;; ---------
;; Ledger
;; ---------
;; (setenv "LEDGER" "/home/cwebber/records/ledger.dat")
;; (load "~/elisp/ledger.el")

;; (defun my-open-my-ledger-file ()
;;   "Opens my usual ledger file ands sets up for ledgerin'."
;;   (interactive)
;;   (find-file "~/records/ledger.dat")
;;   (end-of-buffer)
;;   (ledger-mode))
;; (global-set-key (kbd "C-c fl") 'my-open-my-ledger-file)

;;(add-to-list 'load-path "~/programs/ledger/lisp/")
;;(load-file "~/programs/ledger/lisp/ldg-new.el")
(require 'ledger)
(add-to-list 'auto-mode-alist '("\\.ldgr\\'" . ledger-mode))

(set-face-background 'ledger-font-highlight-face "#2a3031")

