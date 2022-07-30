# Many tweaks from
# https://github.com/noctuid/dotfiles/blob/master/browsing/.config/qutebrowser/config.py

config.load_autoconfig()

#TODO: Make custom start page
c.url.start_pages = ['https://startpage.com']
c.url.default_page = 'https://startpage.com'
c.url.searchengines = {
    'DEFAULT': 'https://www.startpage.com/do/dsearch?query={}&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0',
    '!a' : 'https://www.amazon.com/s?k={}',
    '!c' : 'https://camelcamelcamel.com/search?sq={}',
    '!d' : 'https://duckduckgo.com/?ia=web&q={}',
    '!e' : 'https://www.ebay.com/sch/i.html?_nkw={}',
    '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
    '!m' : 'https://www.openstreetmap.org/search?query={}',
    '!p' : 'https://pry.sh/{}',
    '!r' : 'https://www.reddit.com/search?q={}',
    '!st': 'https://www.startpage.com/do/dsearch?query={}&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0https://www.startpage.com/do/dsearch?query=hello&cat=web&pl=ext-ff&language=english&extVersion=1.3.0',
    '!sd': 'https://slickdeals.net/newsearch.php?q={}&searcharea=deals&searchin=first',
    '!w' : 'https://en.wikipedia.org/wiki/{}',
    '!yt': 'https://www.youtube.com/results?search_query={}'
}

c.tabs.position = 'top'
c.scrolling.smooth = False

# Restore opened sites when opening
c.auto_save.session = True
c.session.lazy_restore = True

# Fingerprinting resistance
c.content.headers.user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.63 Safari/537.36'
c.content.headers.accept_language = 'en-US,en;q=0.5'
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"}

c.content.javascript.enabled = False
c.content.javascript.can_access_clipboard = False

c.content.cookies.accept = 'no-3rdparty'
c.content.headers.referer = 'same-domain'
c.content.webgl = False
c.content.autoplay = False
c.content.canvas_reading = False

c.content.blocking.enabled = True
c.downloads.prevent_mixed_content = True

# What characters should be used for hints
c.hints.chars = 'marstgzxcdvkwluy'

c.downloads.location.directory = '~/dls'
#c.downloads.location.prompt = False

# Basic movement
config.bind('n', 'run-with-count 3 scroll left')
config.bind('e', 'run-with-count 3 scroll down')
config.bind('i', 'run-with-count 3 scroll up')
config.bind('o', 'run-with-count 3 scroll right')

config.bind('n', 'move-to-prev-char', 'caret')
config.bind('e', 'move-to-next-line', 'caret')
config.bind('i', 'move-to-prev-line', 'caret')
config.bind('o', 'move-to-next-char', 'caret')

config.bind('N', 'move-to-prev-word', 'caret')
config.bind('O', 'move-to-next-word', 'caret')

# Tab navigation
config.bind('E',  'tab-prev')
config.bind('I',  'tab-next')
config.bind('ge', 'tab-move -')
config.bind('gi', 'tab-move +')

# History navigation
config.bind('N', 'back')
config.bind('O', 'forward')

config.bind('l', 'mode-enter insert')

# Opening tabs
config.bind('k', 'set-cmd-text --space :open')
config.bind('K', 'set-cmd-text --space :open --tab')

# Disables Ctrl shortcuts
config.bind('<Ctrl-q>', 'nop')
config.bind('<Ctrl-w>', 'nop')

# Search
config.bind('h', 'search-next')
config.bind('H', 'search-previous')

# App integrations
# TODO: Some other ideas: 
# neovide, zathura, imv, GIMP, nvim, nnn (for archives)
config.bind(',m', 'hint links spawn --detach mpv {hint-url}')
config.bind(',M', 'spawn --detach mpv {url}')
config.bind(',f', 'hint links spawn --detach freetube {hint-url}')
config.bind(',F', 'spawn --detach freetube {url}')

# M toggles bookmark status
config.bind('M', 'bookmark-add --toggle')

# gF opens source in editor
config.bind('gF', 'view-source --edit')

# buku integration for bookmarks
config.bind('m', 'set-cmd-text -s :spawn --detach buku --add "{url}"')

# Toggles JavaScript on sites
config.bind('j', 'config-cycle content.javascript.enabled')
