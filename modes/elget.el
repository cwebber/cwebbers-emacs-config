(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(require 'el-get)

;; local sources
(setq el-get-sources
      '((:name magit
               :after (lambda () (global-set-key (kbd "C-x C-z") 'magit-status)))

        (:name asciidoc
               :type elpa
               :after (lambda ()
                        (autoload 'doc-mode "doc-mode" nil t)
                        (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
                        (add-hook 'doc-mode-hook '(lambda ()
                                                    (turn-on-auto-fill)
                                                    (require 'asciidoc)))))
        (:name lisppaste        :type elpa)
        ;(:name nxhtml           :type elpa)
        ;(:name dictionary-el    :type apt-get)
        ;(:name emacs-goodies-el :type apt-get)
        ))

(setq my-packages
      (append
       '(cssh el-get switch-window
              vkill google-maps xcscope yasnippet
              org-mode)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)
