(require 'elfeed)

(setq elfeed-feeds
      '(;; programming
        "http://wingolog.org/feed/atom"
        "http://planet.gnu.org/atom.xml"
        "http://lambda-the-ultimate.org/rss.xml"
        "http://nullprogram.com/feed/"

        ;; comics
        "http://xkcd.com/atom.xml"
        "http://www.oursuperadventure.com/feed/"
        "http://www.octopuspie.com/feed/atom/"))

(setq elfeed-show-entry-switch
      'switch-to-buffer)
