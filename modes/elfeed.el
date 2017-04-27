(require 'elfeed)

(setq elfeed-feeds
      '(;; programming or other blogs
        "http://wingolog.org/feed/atom"
        "http://planet.gnu.org/atom.xml"
        "http://lambda-the-ultimate.org/rss.xml"
        "http://nullprogram.com/feed/"
        "http://www.more-magic.net/feed.atom"
        "http://joeyh.name/blog/index.rss"
        "http://gondwanaland.com/mlog/feed/"
        "http://www.rants.org/feed/atom/"

        ;; Disabled, for now...
        ;; "http://nautil.us/rss/all"

        ;; comics
        "http://xkcd.com/atom.xml"
        "http://www.oursuperadventure.com/feed/"
        "http://feeds2.feedburner.com/sydneypadua/yBZX"  ; 2dgoggles
        "http://www.octopuspie.com/feed/atom/"))

(setq elfeed-show-entry-switch
      'switch-to-buffer)
