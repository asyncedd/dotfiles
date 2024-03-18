{
  inputs,
  lib,
  ...
}: let
  engines = {
    "Wikipedia (en)".metaData.alias = "@wiki";
    "Google".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Amazon.co.jp".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
  };
  userChrome = ''
    @import "${inputs.arcwtf}/userChrome.css";
  '';
  userContent = ''
    @import "${inputs.arcwtf}/userContent.css";
  '';
  smoothScrolling = ''
    user_pref("general.smoothScroll.mouseWheel.durationMaxMS", 100);
    user_pref("general.smoothScroll.mouseWheel.durationMinMS", 100);
    user_pref("general.smoothScroll.pages.durationMaxMS", 100);
    user_pref("general.smoothScroll.pages.durationMinMS", 100);
    user_pref("general.smoothScroll.pixels.durationMaxMS", 100);
    user_pref("general.smoothScroll.pixels.durationMinMS", 100);
    user_pref("general.smoothScroll.scrollbars.durationMaxMS", 100);
    user_pref("general.smoothScroll.scrollbars.durationMinMS", 100);
    user_pref("general.smoothScroll.stopDecelerationWeighting", 1);
  '';
  disableGeoLocation = ''
    user_pref("geo.enabled", false);

    // Use Mozilla geolocation service instead of Google if permission is granted [FF74+]
    user_pref("geo.provider.network.url", "");
    // user_pref("geo.provider.network.logging.enabled", true); // [HIDDEN PREF]
    // -------------------------------------
    // Disable using the OS's geolocation service
    user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
    user_pref("geo.provider.use_corelocation", false); // [MAC]
    user_pref("geo.provider.use_gpsd", false); // [LINUX] [HIDDEN PREF]
    user_pref("geo.provider.geoclue.always_high_accuracy", false); // [LINUX]
    user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]
    // -------------------------------------
    // Disable region updates
    user_pref("browser.region.network.url", ""); // [FF78+] Defense-in-depth
    user_pref("browser.region.update.enabled", false); // [FF79+]
  '';
  # Begone, safe browsing
  disableSafeBrowsing = ''
    user_pref("browser.safebrowsing.malware.enabled", false);
    user_pref("browser.safebrowsing.phishing.enabled", false);
    user_pref("browser.safebrowsing.downloads.enabled", false);

    user_pref("browser.safebrowsing.downloads.remote.url", "");
    user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
    user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
    user_pref("browser.safebrowsing.allowOverride", false);
  '';
  search = {
    force = true;
    default = "DuckDuckGo";
    privateDefault = "DuckDuckGo";
    inherit engines;
  };
in {
  imports = [
    ./addons/ublock.nix
    ./policies.nix
  ];
  programs = {
    firefox = {
      enable = true;
      profiles.async = {
        id = 0;
        name = "async";
        isDefault = true;
        inherit search;
        extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          # # (builtins.readFile "${inputs.edge-frfox}/user.js")
          # smoothScrolling
          # disableSafeBrowsing
          # disableGeoLocation
          ''
                  user_pref("browser.startup.page", 3); // 0102
                  // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
                  // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
                  user_pref("privacy.clearOnShutdown.history", false); // 2811
                  // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

                  user_pref("network.trr.mode", 3);
                  user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");

            user_pref("svg.context-properties.content.enabled", true);
          ''
        ];
        inherit userChrome userContent;
      };
      profiles.arkenfox = {
        id = 1;
        name = "arkenfox";
        isDefault = false;
        inherit search;
        extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.arkenfox}/user.js")
          ''
            user_pref("browser.formfill.enable", true);
          ''
        ];
      };
    };
  };
}
