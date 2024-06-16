{ lib, ... }: {
  programs.firefox.policies."3rdparty".Extensions."uBlock0@raymondhill.net" = {
    adminSettings = {
      dynamicFilteringString = lib.concatMapStrings (x: x + "\n") [
        "no-cosmetic-filtering: * true"
        "no-csp-reports: * true"
        "no-large-media: behind-the-scene false"
        "behind-the-scene * * noop"
        "behind-the-scene * inline-script noop"
        "behind-the-scene * 1p-script noop"
        "behind-the-scene * 3p-frame noop"
        "behind-the-scene * image noop"
        "behind-the-scene * 3p noop"
        "* * 3p-frame block"
        "* * 3p-script block"
        ""
        "duolingo.com * 3p-frame noop"
        "github.com githubassets.com * noop"
        "chatgpt.com oaistatic.com * noop"
        "x.com * 3p-frame noop"
        "x.com edgecastcdn.net * noop"
        "x.com twimg.com * noop"
        "x.com twitter.com * noop"
        "reddit.com redditstatic.com * noop"
        "www.reddit.com reddit.map.fastly.net * noop"
        "youtube.com * 3p-frame noop"
        "youtube.com * 3p-script noop"
        "* jquery.com * noop"
        "* fontawesome.com * noop"
        "* gstatic.com * noop"
        "* cloudflare.net * noop"
        "* fastly.net * noop"
        "* *.fastly.net * noop"
        "* jsdelivr.net * noop"
        "* *.cloudfront.net * noop"
        "* cloudfront.net * noop"
        ""
        "* cloudflare.com * noop"
        "* recaptcha.net * noop"
        "* google.com * noop"
        "* unpkg.com * noop"
        "* youtube-nocookie.com * noop"
        ""
        "knowyourmeme.com kym-cdn.com * noop"
        "knowyourmeme.com llnwi.net * noop"
        ""
        "lichess.org lichess1.org * noop"
        "wallhaven.cc whvn.cc * noop"
        ""
        "open.spotify.com spotifycdn.com * noop"
        "open.spotify.com spotifycdn.map.fastly.net * noop"
        "open.spotify.com scdn.co * noop"
        "open.spotify.com spotify.map.fastly.net * noop"
        ""
        "msn.com d.akamaiedge.net * noop"
        ""
        "* gravatar.com * noop"
        ""
        "no-cosmetic-filtering: youtube.com false"
      ];
      userFilters = lib.concatMapStrings (x: x + "\n") [
        # "! (Firefox below 121) - Hide Homepage Videos Below 1K Views"
        # "www.youtube.com##ytd-browse[page-subtype=\"home\"] #video-title-link:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-rich-item-renderer)"
        "! (Chromium + FF121+) - Hide Homepage Videos Below 1K Views"
        ''
          www.youtube.com##ytd-browse[page-subtype="home"] ytd-rich-item-renderer:has(#video-title:not(:is([aria-label*=",0"],[aria-label*=",1"],[aria-label*=",2"],[aria-label*=",3"],[aria-label*=",4"],[aria-label*=",5"],[aria-label*=",6"],[aria-label*=",7"],[aria-label*=",8"],[aria-label*=",9"])))''
        # "! (Firefox below 121) - Hide Sidebar Videos Below 1K Views"
        # "www.youtube.com##ytd-compact-video-renderer #video-title:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-compact-video-renderer)"
        "! (Chromium + FF121+) - Hide Sidebar Videos Below 1K Views"
        ''
          www.youtube.com##ytd-compact-video-renderer:has(#video-title:not(:is([aria-label*=",0"],[aria-label*=",1"],[aria-label*=",2"],[aria-label*=",3"],[aria-label*=",4"],[aria-label*=",5"],[aria-label*=",6"],[aria-label*=",7"],[aria-label*=",8"],[aria-label*=",9"])))''

        "youtube-nocookie.com,youtube.com##.ytp-pause-overlay, .show-video-thumbnail-button"
        "~youtube-nocookie.com,~youtube.com##iframe ~ #topvbar > #rvid"

        "! YT Search - keep only videos (no shorts), channels and playlists"
        ''
          youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer, ytd-playlist-renderer,yt-showing-results-for-renderer),ytd-video-renderer:has([aria-label="Shorts"])),ytd-secondary-search-container-renderer''

        "! Move homepage placeholders to the end"
        ''
          www.youtube.com##ytd-browse[page-subtype="home"] :is(ytd-rich-grid-row, #contents.ytd-rich-grid-row):style(display: contents !important)''

        "/annotations_module.js$script,xhr,important,domain=youtube.com"
        "/endscreen.js$script,xhr,important,domain=youtube.com"

        "youtube.com##.ytp-button.ytp-cards-button"
        "youtube.com##.ytp-button.branding-img-container"
        "youtube.com##.ytp-suggested-action"

        "youtube.com##.ytp-quality-menu .ytp-menuitem:has(.ytp-premium-label)"
        "youtube.com##ytd-popup-container > tp-yt-paper-dialog > ytd-mealbar-promo-renderer, ytd-popup-container > tp-yt-paper-dialog > yt-mealbar-promo-renderer:has-text(/Claim Offer|Join now|Not Now|No thanks|YouTube TV|live TV|Live TV|movies|sports|Try it free|unlimited DVR|watch NFL/)"

        "! Hide related searches and related results from the YouTube search results, only leaving organic matches for your search"
        "www.youtube.com##ytd-search ytd-item-section-renderer ytd-shelf-renderer"
        "www.youtube.com##ytd-search ytd-item-section-renderer ytd-horizontal-card-list-renderer"

        # "! Hide next video video, which may accidentally be clicked since it's near the Play button"
        # "www.youtube.com##.ytp-button.ytp-next-button"

        "! REDDIT"
        "! Hide AutoModerator comments"
        "! https://www.reddit.com/r/uBlockOrigin/comments/140lp15/any_way_to_hide_automoderator_comments_with_ublock/"
        ''
          reddit.com##[data-testid="comment_author_link"][href="/user/AutoModerator/"]:upward(.Comment)''
        ''
          reddit.com##.comment .author[href="https://old.reddit.com/user/AutoModerator"]:upward(.comment)''
        ''! To hide AutoModerator, anyone who contains "mod" or "bot"''
        ''old.reddit.com##.comment[data-author="AutoModerator"]''
        ''! old.reddit.com##.comment[data-author*="mod"]''
        ''old.reddit.com##.comment[data-author*="bot"]''
        "! To hide any mod"
        "! old.reddit.com##.comment:has(.entry .tagline .moderator)"
        "! Hide Moderator section"
        "www.reddit.com###moderation_section"

        "youtube.com##ytd-rich-grid-renderer:style(--ytd-rich-grid-items-per-row: 6 !important;)"
        "youtube.com##ytd-rich-grid-renderer:style(--ytd-rich-grid-posts-per-row: 6 !important;)"
        "youtube.com##ytd-two-column-browse-results-renderer.grid-6-columns:style(width: 100% !important;)"
        "youtube.com##ytd-rich-grid-row, #contents.ytd-rich-grid-row:style(display:contents !important;)"
        "youtube.com##ytd-two-column-browse-results-renderer.grid:not(.grid-disabled):style(max-width: 100% !important;)"
      ];
      hostnameSwitchesString = lib.concatMapStrings (x: x + "\n") [
        "no-large-media: behind-the-scene false"
        "no-csp-reports: * true"
      ];
    };
    advancedSettings =
      [ [ "cnameMaxTTL" "720" ] [ "filterAuthorMode" "true" ] ];
    userSettings = [
      [ "advancedUserEnabled" "true" ]
      [ "ignoreGeneticCosmeticFilters" "true" ]
      [ "popupPanelSections" "31" ]
      [ "prefetchingDisabled" "false" ]
    ];
    toOverwrite = {
      filterLists = [
        "user-filters"
        "ublock-filters"
        "ublock-badware"
        "ublock-privacy"
        "ublock-quick-fixes"
        "ublock-unbreak"
        "block-lan"
        "easyprivacy"
        "urlhaus-1"
        "plowe-0"
        "ublock-annoyances"
        "adguard-generic"
        "adguard-spyware"
        "adguard-spyware-url"
        "adguard-popup-overlays"
        "adguard-social"
        "adguard-widgets"
        "adguard-cookies"
        "ublock-cookies-adguard"
        "easylist-chat"
        "easylist-newsletters"
        "easylist-notifications"
        "easylist-annoyances"
        "fanboy-social"
        "fanboy-cookiemonster"
        "ublock-cookies-easylist"
        "easylist"
        "JPN-1"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
      ];
      externalLists = lib.concatMapStrings (x: x + "\n") [
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
      ];
      importedLists = [
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/youtube_clear_view.txt"
        # "https://raw.githubusercontent.com/yokoffing/filterlists/main/click2load.txt"
      ];
      trustedSiteDirectives = [
        "about-scheme"
        "chrome-extension-scheme"
        "chrome-scheme"
        "edge-scheme"
        "moz-extension-scheme"
        "opera-scheme"
        "vivaldi-scheme"
        "wyciwyg-scheme"
      ];
    };
  };
}
