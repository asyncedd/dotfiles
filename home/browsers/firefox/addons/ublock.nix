{lib, ...}: {
  programs.firefox.policies."3rdparty".Extensions."uBlock0@raymondhill.net" = {
    adminSettings = {
      dynamicFilteringString = lib.concatMapStrings (x: x + "\n") [
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
        "twitter.com * 3p-frame noop"
        "reddit.com redditstatic.com * noop"
        "youtube.com * 3p-frame noop"
        "* jquery.com * noop"
        "* fontawesome.com * noop"
        "* gstatic.com * noop"
        ""
        "* cloudflare.com * noop"
        "* recaptcha.net * noop"
        "* google.com/recaptcha * noop"
      ];
      userFilters = lib.concatMapStrings (x: x + "\n") [
        "! YT Homepage and Subscriptions - Hide the Shorts section"
        "youtube.com##[is-shorts]"
        "! YT Menu - Hide the Shorts button"
        "www.youtube.com###guide [title=\"Shorts\"], .ytd-mini-guide-entry-renderer[title=\"Shorts\"]"
        "! YT Search - Hide Shorts"
        "www.youtube.com##ytd-search ytd-video-renderer:has([overlay-style=\"SHORTS\"])"
        "! YT Search, Channels and Sidebar or below the player - Hide the Shorts sections"
        "www.youtube.com##ytd-reel-shelf-renderer"
        "! YT Channels - Hide the Shorts tab"
        "www.youtube.com##[tab-title=\"Shorts\"]"
        "! YT Subscriptions - Hide Shorts - Grid View"
        "www.youtube.com##ytd-browse[page-subtype=\"subscriptions\"] ytd-grid-video-renderer:has([overlay-style=\"SHORTS\"])"
        "! YT Subscriptions - Hide Shorts - List View"
        "www.youtube.com##ytd-browse[page-subtype=\"subscriptions\"] ytd-video-renderer:has([overlay-style=\"SHORTS\"])"
        "! YT Subscriptions - New Layout - Hide Shorts"
        "www.youtube.com##ytd-browse[page-subtype=\"subscriptions\"] ytd-rich-item-renderer:has([overlay-style=\"SHORTS\"])"
        "! YT Sidebar - Hide Shorts"
        "www.youtube.com###related ytd-compact-video-renderer:has([overlay-style=\"SHORTS\"])"
        ""
        "! YT Mobile - Hide the Shorts Menu button"
        "m.youtube.com##ytm-pivot-bar-item-renderer:has(>.pivot-shorts)"
        "! YT Mobile - Hide the Shorts sections"
        "m.youtube.com##ytm-reel-shelf-renderer"
        "! YT Mobile - Hide Shorts in search results"
        "m.youtube.com##ytm-search ytm-video-with-context-renderer:has([data-style=\"SHORTS\"])"
        "! YT Mobile - Hide the Shorts button on Channels"
        "m.youtube.com##[tab-title=\"Shorts\"]"

        # "! (Firefox below 121) - Hide Homepage Videos Below 1K Views"
        # "www.youtube.com##ytd-browse[page-subtype=\"home\"] #video-title-link:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-rich-item-renderer)"
        "! (Chromium + FF121+) - Hide Homepage Videos Below 1K Views"
        "www.youtube.com##ytd-browse[page-subtype=\"home\"] ytd-rich-item-renderer:has(#video-title:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])))"
        # "! (Firefox below 121) - Hide Sidebar Videos Below 1K Views"
        # "www.youtube.com##ytd-compact-video-renderer #video-title:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])):upward(ytd-compact-video-renderer)"
        "! (Chromium + FF121+) - Hide Sidebar Videos Below 1K Views"
        "www.youtube.com##ytd-compact-video-renderer:has(#video-title:not(:is([aria-label*=\",0\"],[aria-label*=\",1\"],[aria-label*=\",2\"],[aria-label*=\",3\"],[aria-label*=\",4\"],[aria-label*=\",5\"],[aria-label*=\",6\"],[aria-label*=\",7\"],[aria-label*=\",8\"],[aria-label*=\",9\"])))"

        "youtube-nocookie.com,youtube.com##.ytp-pause-overlay, .show-video-thumbnail-button"
        "~youtube-nocookie.com,~youtube.com##iframe ~ #topvbar > #rvid"

        "! YT Search - keep only videos (no shorts), channels and playlists"
        "youtube.com##ytd-search ytd-item-section-renderer>#contents>:is(:not(ytd-video-renderer,ytd-channel-renderer, ytd-playlist-renderer,yt-showing-results-for-renderer),ytd-video-renderer:has([aria-label=\"Shorts\"])),ytd-secondary-search-container-renderer"

        "! Move homepage placeholders to the end"
        "www.youtube.com##ytd-browse[page-subtype=\"home\"] :is(ytd-rich-grid-row, #contents.ytd-rich-grid-row):style(display: contents !important)"

        "/annotations_module.js$script,xhr,important,domain=youtube.com"
        "/endscreen.js$script,xhr,important,domain=youtube.com"

        "youtube.com##.ytp-button.ytp-cards-button"
        "youtube.com##.ytp-button.branding-img-container"
        "youtube.com##.ytp-suggested-action"

        "youtube.com##.ytp-quality-menu .ytp-menuitem:has(.ytp-premium-label)"
        "youtube.com##ytd-popup-container > tp-yt-paper-dialog > ytd-mealbar-promo-renderer, ytd-popup-container > tp-yt-paper-dialog > yt-mealbar-promo-renderer:has-text(/Claim Offer|Join now|Not Now|No thanks|YouTube TV|live TV|Live TV|movies|sports|Try it free|unlimited DVR|watch NFL/)"
      ];
      hostnameSwitchesString = lib.concatMapStrings (x: x + "\n") [
        "no-large-media: behind-the-scene false"
        "no-csp-reports: * true"
      ];
    };
    advancedSettings = [
      ["cnameMaxTTL" "720"]
      ["filterAuthorMode" "true"]
      ["updateAssetBypassBrowserCache" "true"]
    ];
    userSettings = [
      ["advancedUserEnabled" "true"]
      ["ignoreGeneticCosmeticFilters" "true"]
      ["popupPanelSections" "31"]
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
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt"
        "https://big.oisd.nl/"
      ];
      externalLists = "https://filters.adtidy.org/extension/ublock/filters/101_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/122_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/14_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/2_optimized.txt\nhttps://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt\nhttps://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt\nhttps://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt\nhttps://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt\nhttps://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt\nhttps://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt\nhttps://big.oisd.nl/";
      importedLists = [
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
        "https://big.oisd.nl/"
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
