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
    "SearX (puffyan)" = {
      urls = [
        {
          template = "https://searx.puffyan.us/search?q={searchTerms}&category_general=1&language=auto&time_range=&safesearch=0&theme=simple";
        }
      ];
      iconUpdateURL = "https://searx.puffyan.us/favicon.ico";
      updateInterval = 24 * 60 * 60 * 1000; # every day
      definedAliases = ["!searx"];
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

            ///  NATURAL SMOOTH SCROLLING V4 "SHARP" - AveYo, 2020-2022             preset     [default]
            ///  copy into firefox/librewolf profile as user.js, add to existing, or set in about:config
            user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS",   12);//NSS    [120]
            user_pref("general.smoothScroll.msdPhysics.enabled",                    true);//NSS  [false]
            user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant",   200);//NSS   [1250]
            user_pref("general.smoothScroll.msdPhysics.regularSpringConstant",       250);//NSS   [1000]
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS",           25);//NSS     [12]
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio",     "2.0");//NSS    [1.3]
            user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant",      250);//NSS   [2000]
            user_pref("general.smoothScroll.currentVelocityWeighting",             "1.0");//NSS ["0.25"]
            user_pref("general.smoothScroll.stopDecelerationWeighting",            "1.0");//NSS  ["0.4"]

            /// adjust multiply factor for mousewheel - or set to false if scrolling is way too fast
            user_pref("mousewheel.system_scroll_override.horizontal.factor",         200);//NSS    [200]
            user_pref("mousewheel.system_scroll_override.vertical.factor",           200);//NSS    [200]
            user_pref("mousewheel.system_scroll_override_on_root_content.enabled",  true);//NSS   [true]
            user_pref("mousewheel.system_scroll_override.enabled",                  true);//NSS   [true]

            /// adjust pixels at a time count for mousewheel - cant do more than a page at once if <100
            user_pref("mousewheel.default.delta_multiplier_x",                       100);//NSS    [100]
            user_pref("mousewheel.default.delta_multiplier_y",                       100);//NSS    [100]
            user_pref("mousewheel.default.delta_multiplier_z",                       100);//NSS    [100]

            ///  this preset will reset couple extra variables for consistency
            user_pref("apz.allow_zooming",                                          true);//NSS   [true]
            user_pref("apz.force_disable_desktop_zooming_scrollbars",              false);//NSS  [false]
            user_pref("apz.paint_skipping.enabled",                                 true);//NSS   [true]
            user_pref("apz.windows.use_direct_manipulation",                        true);//NSS   [true]
            user_pref("dom.event.wheel-deltaMode-lines.always-disabled",           false);//NSS  [false]
            user_pref("general.smoothScroll.durationToIntervalRatio",                200);//NSS    [200]
            user_pref("general.smoothScroll.lines.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.lines.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.other.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.other.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pages.durationMaxMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pages.durationMinMS",                    150);//NSS    [150]
            user_pref("general.smoothScroll.pixels.durationMaxMS",                   150);//NSS    [150]
            user_pref("general.smoothScroll.pixels.durationMinMS",                   150);//NSS    [150]
            user_pref("general.smoothScroll.scrollbars.durationMaxMS",               150);//NSS    [150]
            user_pref("general.smoothScroll.scrollbars.durationMinMS",               150);//NSS    [150]
            user_pref("general.smoothScroll.mouseWheel.durationMaxMS",               200);//NSS    [200]
            user_pref("general.smoothScroll.mouseWheel.durationMinMS",                50);//NSS     [50]
            user_pref("layers.async-pan-zoom.enabled",                              true);//NSS   [true]
            user_pref("layout.css.scroll-behavior.spring-constant",                "250");//NSS    [250]
            user_pref("mousewheel.transaction.timeout",                             1500);//NSS   [1500]
            user_pref("mousewheel.acceleration.factor",                               10);//NSS     [10]
            user_pref("mousewheel.acceleration.start",                                -1);//NSS     [-1]
            user_pref("mousewheel.min_line_scroll_amount",                             5);//NSS      [5]
            user_pref("toolkit.scrollbox.horizontalScrollDistance",                    5);//NSS      [5]
            user_pref("toolkit.scrollbox.verticalScrollDistance",                      3);//NSS      [3]
            ///
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
