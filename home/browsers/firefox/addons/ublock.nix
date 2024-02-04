{
  programs.firefox.policies."3rdparty".Extensions."uBlock0@raymondhill.net" = {
    advancedSettings = [
      [ "cnameMaxTTL" "720" ]
      [ "filterAuthorMode" "true" ]
      [ "updateAssetBypassBrowserCache" "true" ]
    ];
    userSettings = [
      [ "advancedUserEnabled" "true" ]
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
         "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
         "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
         "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
         "https://filters.adtidy.org/extension/ublock/filters/14_optimized.txt"
         "https://filters.adtidy.org/extension/ublock/filters/2_optimized.txt"
         "https://filters.adtidy.org/extension/ublock/filters/122_optimized.txt"
         "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/personal.txt"
         "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt"
         "https://small.oisd.nl/" # big.oisd.nl adds too much lol
      ];
      externalLists = "https://filters.adtidy.org/extension/ublock/filters/101_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/122_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/14_optimized.txt\nhttps://filters.adtidy.org/extension/ublock/filters/2_optimized.txt\nhttps://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt\nhttps://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt\nhttps://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/personal.txt\nhttps://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt\nhttps://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt\nhttps://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt\nhttps://small.oisd.nl/";
      importedLists = [
        "https://filters.adtidy.org/extension/ublock/filters/101_optimized.txt"
        "https://filters.adtidy.org/extension/ublock/filters/122_optimized.txt"
        "https://filters.adtidy.org/extension/ublock/filters/14_optimized.txt"
        "https://filters.adtidy.org/extension/ublock/filters/2_optimized.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
        "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Special%20security%20lists/AntiFaviconList.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/personal.txt"
        "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds-ublock.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/annoyance_list.txt"
        "https://raw.githubusercontent.com/yokoffing/filterlists/main/privacy_essentials.txt"
        "https://small.oisd.nl/"
      ];
      popupPanelSections = "31";
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
      dynamicFilteringString = [ 
        "behind-the-scene * * noop"
        "behind-the-scene * inline-script noop"
        "behind-the-scene * 1p-script noop"
        "behind-the-scene * 3p-script noop"
        "behind-the-scene * 3p-frame noop"
        "behind-the-scene * image noop"
        "behind-the-scene * 3p noop"
        "* * 3p-frame block"
      ];
      hostnameSwitchesString = [
        "no-large-media: behind-the-scene false"
        "no-csp-reports: * true"
      ];
    };
  };
}

