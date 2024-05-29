{
  inputs,
  lib,
  pkgs,
  ...
}: let
  engines = {
    "Wikipedia (en)".metaData.alias = "@wiki";
    "Google".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Amazon.co.jp".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;

    "Noogle" = {
      urls = [
        {
          template = "https://noogle.dev/q?term={searchTerms}";
        }
      ];
      iconUpdateURL = "https://noogle.dev/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@ng"];
    };
    "MyNixOS" = {
      urls = [
        {
          template = "https://mynixos.com/search?q={searchTerms}";
        }
      ];
      iconUpdateURL = "https://mynixos.com/favicon-dark.svg";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@mno"];
    };
    "Home Manager Options" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com/?query={searchTerms}";
        }
      ];
      iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["@hm"];
    };
  };
  userChrome = ''
    @import "${inputs.arcwtf}/userChrome.css";
  '';
  userContent = ''
    @import "${inputs.arcwtf}/userContent.css";
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
      package = pkgs.firefox-beta;
      profiles.async = {
        id = 0;
        name = "async";
        isDefault = true;
        inherit search;
        extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          ''
            user_pref("browser.startup.page", 3); // 0102
            // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
            user_pref("privacy.clearOnShutdown.history", false); // 2811
            // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

            user_pref("network.trr.mode", 3);
            user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");

            user_pref("svg.context-properties.content.enabled", true);
            user_pref("gfx.webrender.all", true);
            user_pref("extensions.activeThemeID", "arc-dark-theme@afnankhan");
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
