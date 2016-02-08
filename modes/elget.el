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
     (let (el-get-master-branch)
       (goto-char (point-max))
       (eval-print-last-sexp)))))

(require 'el-get)

;; local sources
(setq el-get-sources
      '((:name "yasnippet"
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
        (:name "highlight-parentheses"
               :description "Highlight parentheses"
               :type git
               :url "https://github.com/nschum/highlight-parentheses.el.git")
        (:name "naquadah-theme"
               :description "Naquadah theme"
               :type git
               :url "https://github.com/jd/naquadah-theme.git")
        (:name "kivy-mode"
               :description "Kivy highlighting mode"
               :type http
               :url "https://raw.github.com/kivy/kivy/master/kivy/tools/highlight/kivy-mode.el")
        (:name "rainbow-delimeters"
               :description "Highlight rainbowz"
               :type http
               :url "http://github.com/jlr/rainbow-delimiters/raw/master/rainbow-delimiters.el")
        (:name "web-mode"
               :description "emacs major mode for html templates"
               :type git
               :url "https://github.com/fxbois/web-mode.git")
        (:name "org-reveal"
               :description "reveal.js stuff for orgmode"
               :type git
               :url "https://github.com/yjwen/org-reveal.git")
        ;; (:name "geiser"
        ;;        :type elpa
        ;;        :repo ("marmalade" . "http://marmalade-repo.org/packages/"))
        (:name "replace-color-themes"
               :type git
               :url "https://github.com/emacs-jp/replace-colorthemes.git")
        (:name "popup"
               :type elpa
               :repo ("marmalade" . "http://marmalade-repo.org/packages/"))
        (:name "git-modes"
               :type elpa
               :repo ("marmalade" . "http://marmalade-repo.org/packages/"))
        (:name "magit"
               :type elpa
               :repo ("marmalade" . "http://marmalade-repo.org/packages/"))
        (:name "magit-annex"
               :type elpa
               :repo ("marmalade" . "http://marmalade-repo.org/packages/"))
        ;; (:name "timesheet"
        ;;        :type elpa)



        ;; (:name magit
        ;;        :website "https://github.com/magit/magit#readme"
        ;;        :description "It's Magit! An Emacs mode for Git."
        ;;        :type github
        ;;        :pkgname "magit/magit"
        ;;        :depends (cl-lib git-modes)
        ;;        :info "."
        ;;        :branch "next"
        ;;        ;; let el-get care about autoloads so that it works with all OSes
        ;;        :build (if (version<= "24.3" emacs-version)
        ;;                   `(("make" ,(format "EMACS=%s" el-get-emacs) "all"))
        ;;                 `(("make" ,(format "EMACS=%s" el-get-emacs) "docs")))
        ;;        :build/berkeley-unix (("touch" "`find . -name Makefile`") ("gmake")))
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
       '("el-get" "calfw" "ace-jump-mode"
         "paredit" "visual-regexp" "web-mode" "smex"
         "browse-kill-ring" "hy-mode" "rainbow-mode"
         ; "smartparens"
         "helm"
         "rainbow-delimeters"
         "jedi" "haskell-mode"
         ;; "geiser"
         "switch-window"
         "git-timemachine"
         "sicp")
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-packages)
