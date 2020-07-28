;; ---------
;; ERC
;; ---------

;; (setq browse-url-browser-function 'w3m-browse-url)

(setq erc-user-full-name user-full-name)

(require 'erc-track)
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART"
 				"QUIT" "MODE"))

(setq erc-log-channels-directory "~/.erc/logs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps t)
(setq erc-join-buffer 'window-noselect)

; automatically log conversations
(require 'erc-log)
(erc-log-mode t)
(add-hook 'erc-insert-post-hook 'erc-save-buffer-in-logs)
(erc-scrolltobottom-mode t)
(load-file "~/.erc/config.el")

; Truncate
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)
(setq erc-max-buffer-size 100000)
