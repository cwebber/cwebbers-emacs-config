(require 'helm)
(require 'helm-pages)

(global-set-key (kbd "C-x B") 'helm-buffers-list)
(global-set-key (kbd "M-s O") 'helm-occur)
(global-set-key (kbd "M-X") 'helm-M-x)
(global-set-key (kbd "C-c f h") 'helm-find-files)

(global-set-key (kbd "C-c h b") 'helm-buffers-list)
(global-set-key (kbd "C-c h f") 'helm-find-files)
(global-set-key (kbd "C-c h F") 'helm-find)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h p") 'helm-pages)
(global-set-key (kbd "C-c h x") 'helm-M-x)
