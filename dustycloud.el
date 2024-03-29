(setq dustycloud-content-dir "~/devel/dustycloud/posts/")

(setq dustycloud-rst-snippet "${1:$(make-string (string-width yas/text) ?\=)}
${1:Title}
${1:$(make-string (string-width yas/text) ?\=)}

:date: `(format-time-string \"\%Y-\%m-\%d \%H:\%M\")`
:author: Christine Lemmer-Webber
:tags: $2

$0")

(setq dustycloud-md-snippet "title: ${1:Title}
date: `(format-time-string \"\%Y-\%m-\%d \%H:\%M\")`
author: Christine Lemmer-Webber
tags: $2
---
$0")

(setq dustycloud-html-snippet "title: ${1:Title}
date: `(format-time-string \"\%Y-\%m-\%d \%H:\%M\")`
author: Christine Lemmer-Webber
tags: $2
---
$0
")


(defun dustycloud-compose ()
  "Compose a new document for the dustycloud blog"
  (interactive)
  (let ((default-directory dustycloud-content-dir))
    (call-interactively 'find-file))
  (let ((file-extension
         (progn (string-match "\\.\\(html\\|rst\\|md\\)$" buffer-file-name)
                (match-string 1 buffer-file-name)))
        (yas/indent-line nil)
        (yas/wrap-around-region nil))
    ;; Expand the appropriate snippet (or throw an error if unrecognized)
    (cond ((equal file-extension "rst")
           (yas-expand-snippet dustycloud-rst-snippet))
          ((equal file-extension "md")
           (yas-expand-snippet dustycloud-md-snippet))
          ((equal file-extension "html")
           (setq-local web-mode-disable-auto-indentation t)
           (yas-expand-snippet dustycloud-html-snippet))
          (t
           (error "File extension not .md or .html")))))


(defun mediagoblin-compose ()
  (interactive)
  (let ((dustycloud-content-dir "~/devel/mediagoblin-website/content/"))
    (dustycloud-compose)))
