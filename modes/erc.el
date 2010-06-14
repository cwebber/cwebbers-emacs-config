;; ---------
;; ERC
;; ---------

(setq erc-nick "paroneayea")
(setq erc-user-full-name user-full-name)
;; (setq browse-url-browser-function 'w3m-browse-url)
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
(setq erc-scrolltobottom-mode t)
