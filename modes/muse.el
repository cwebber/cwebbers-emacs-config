;; ---------
;; Muse
;; ---------

;;; Muse-mode
(require 'muse)
(require 'muse-mode)  ; load authoring mode
(require 'muse-html)  ; load publishing styles I use
(require 'muse-latex)
(require 'muse-project)
;(setq muse-latex-header "./header.tex")

(setq muse-project-alist
      '(("WikiPlanner"
	 ("~/Plans"
	  :default "Taskpool"
	  :major-mode planner-mode
	  :visit-link planner-visit-link)
	 (:base "planner-xhtml"
		:path "~/Documents/planner/"))
        ("dustycloud" ; dustycloud.org stuff
	 ("~/proj/dustycloud/" :default "index")
	 (:base "xhtml" :path "~/Documents/dustycloud"))))

;; (add-to-list 'muse-publish-markup-regexps
;; 	     '(2150 "^SP{\\(.*\\)}: \\(\\(?:.\\|.\n\\)*.\\)\\(?:\n\\|\\'\\)"
;; 		    0 actor))

;; (add-to-list 'muse-publish-markup-functions
;; 	     '(actor . muse-publish-markup-actor))

;(add-hook 'muse-mode-hook 'ruler-mode)

;(require 'muse-latex)
