(require 'company)

;; For now, only the really cool kids (ok, geiser) get global-company-mode
(setq global-company-mode nil)

(setq company-backends
      '(geiser-company-backend
        company-elisp
        company-nxml company-css company-semantic company-capf
        (company-dabbrev-code company-gtags company-etags company-keywords)
        company-oddmuse company-files company-dabbrev))
