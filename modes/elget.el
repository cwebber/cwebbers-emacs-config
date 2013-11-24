(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

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
        (:name "yasnippet"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet")
        (:name "visual-regexp"
               :description "Visual regexps"
               :type git
               :url "https://github.com/benma/visual-regexp.el.git")
        (:name "dark-theme"
               :description "Dark theme"
               :type http
               :url "https://raw.github.com/suvayu/.emacs.d/master/themes/dark-emacs-theme.el")
        (:name "highlight-sexps"
               :description "Highlight sexps"
               :type http
               :url "http://david.rysdam.org/src/emacs/highlight-sexps.el")
        (:name "naquadah-theme"
               :description "Naquadah theme"
               :type git
               :url "git://git.naquadah.org/naquadah-theme.git")
        (:name "kivy-mode"
               :description "Kivy highlighting mode"
               :type http
               :url "https://raw.github.com/kivy/kivy/master/kivy/tools/highlight/kivy-mode.el")
        (:name "web-mode"
               :description "emacs major mode for html templates"
               :type git
               :url "https://github.com/fxbois/web-mode.git")
        (:name "org-reveal"
               :description "reveal.js stuff for orgmode"
               :type git
               :url "https://github.com/yjwen/org-reveal.git")
        ;; (:name "cyberpunk-theme"
        ;;        :description "Cyberpunk theme"
        ;;        :type git
        ;;        :url "https://github.com/n3mo/cyberpunk-theme.el.git")
        ;; (:name asciidoc
        ;;        :type elpa
        ;;        :after (lambda ()
        ;;                 (autoload 'doc-mode "doc-mode" nil t)
        ;;                 (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
        ;;                 (add-hook 'doc-mode-hook '(lambda ()
        ;;                                             (turn-on-auto-fill)
        ;;                                             (require 'asciidoc)))))
        ;(:name lisppaste        :type elpa)
        ;(:name nxhtml           :type elpa)
        ;(:name dictionary-el    :type apt-get)
        ;(:name emacs-goodies-el :type apt-get)
        ))

(setq my-packages
      (append
       '("el-get" "org-mode" "calfw" "ace-jump-mode"
         "paredit" "visual-regexp" "web-mode" "smex"
         ;  "jedi"
         ) ; "dropdown-list")
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)

