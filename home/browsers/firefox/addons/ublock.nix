{lib, ...}: {
  programs.firefox.policies."3rdparty".Extensions."uBlock0@raymondhill.net" = {
    adminSettings = {
      dynamicFilteringString = lib.concatMapStrings (x: x + "\n") [
        "behind-the-scene * * noop"
        "behind-the-scene * inline-script noop"
        "behind-the-scene * 1p-script noop"
        "behind-the-scene * 3p-script noop"
        "behind-the-scene * 3p-frame noop"
        "behind-the-scene * image noop"
        "behind-the-scene * 3p noop"
        "* * 3p-frame block"
        "* * 3p-script block"

        "duolingo.com * 3p-frame noop"
        "duolingo.com * 3p-script noop"
        "github.com * 3p-frame noop"
        "github.com * 3p-script noop"
        "imgur.com * 3p-script noop"
        "scratch.mit.edu * 3p-script noop"
        "chat.openai.com * 3p-script noop"
        "chat.openai.com * 3p-frame noop"
        "quora.com * 3p-script noop"
        "reddit.com * 3p-frame noop"
        "reddit.com * 3p-script noop"
        "youtube.com * 3p-frame noop"
        "youtube.com * 3p-script noop"
        "*.spotify.com * 3p-script noop"

        "internals.rust-lang.org * 3p-script noop"
        "users.rust-lang.org * 3p-script noop"
        "community.brave.com * 3p-script noop"

        "gemini.google.com * 3p-script noop"

        "* challenges.cloudflare.com 3p-script noop"
        "* challenges.cloudflare.com 3p-frame noop"
        "* obsidian.md 3p-script noop"
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
