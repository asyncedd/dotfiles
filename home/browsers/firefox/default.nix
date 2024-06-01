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

            /****************************************************************************
             * SECTION: NETWORK                                                         *
            ****************************************************************************/
            // PREF: increase DNS cache
            // [1] https://developer.mozilla.org/en-US/docs/Web/Performance/Understanding_latency
            user_pref("network.dnsCacheEntries", 1000); // default=400


            /****************************************************************************
             * SECTION: SPECULATIVE LOADING                                            *
            ****************************************************************************/
            // PREF: Fetch Priority API [FF119+]
            // Indicates whether the `fetchpriority` attribute for elements which support it.
            // [1] https://web.dev/articles/fetch-priority
            // [2] https://nitropack.io/blog/post/priority-hints
            // [2] https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/fetchPriority
            // [3] https://developer.mozilla.org/en-US/docs/Web/API/HTMLLinkElement/fetchPriority
            user_pref("network.fetchpriority.enabled", true);


            // PREF: early hints [FF120+]
            // [1] https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/103
            // [2] https://developer.chrome.com/blog/early-hints/
            // [3] https://blog.cloudflare.com/early-hints/
            // [4] https://blog.cloudflare.com/early-hints-performance/
            user_pref("network.early-hints.enabled", true);

            // PREF: `Link: rel=preconnect` in 103 Early Hint response [FF120+]
            // Used to warm most critical cross-origin connections to provide
            // performance improvements when connecting to them.
            // [NOTE] When 0, this is limited by "network.http.speculative-parallel-limit".
            user_pref("network.early-hints.preconnect.enabled", true);
            user_pref("network.early-hints.preconnect.max_connections", 10); // DEFAULT

            /****************************************************************************
             * SECTION: TAB UNLOAD                                                      *
            ****************************************************************************/

            // PREF: unload tabs on low memory
            // [ABOUT] about:unloads
            // Firefox will detect if your computer’s memory is running low (less than 200MB)
            // and suspend tabs that you have not used in awhile.
            // [1] https://support.mozilla.org/en-US/kb/unload-inactive-tabs-save-system-memory-firefox
            // [2] https://hacks.mozilla.org/2021/10/tab-unloading-in-firefox-93/
            user_pref("browser.tabs.unloadOnLowMemory", true); // DEFAULT

            // PREF: determine when tabs unload [WINDOWS] [LINUX]
            // Notify TabUnloader or send the memory pressure if the memory resource
            // notification is signaled AND the available commit space is lower than
            // this value.
            // Set this to some high value, e.g. 2/3 of total memory available in your system:
            // 4GB=2640, 8GB=5280, 16GB=10560, 32GB=21120, 64GB=42240
            // [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
            user_pref("browser.low_commit_space_threshold_mb", 2640); // default=200; WINDOWS LINUX

            // PREF: determine when tabs unload [LINUX]
            // On Linux, Firefox checks available memory in comparison to total memory,
            // and use this percent value (out of 100) to determine if Firefox is in a
            // low memory scenario.
            // [1] https://dev.to/msugakov/taking-firefox-memory-usage-under-control-on-linux-4b02
            user_pref("browser.low_commit_space_threshold_percent", 33); // default=5; LINUX

            // PREF: determine how long (in ms) tabs are inactive before they unload
            // 60000=1min; 300000=5min; 600000=10min (default)
            user_pref("browser.tabs.min_inactive_duration_before_unload", 300000); // 5min; default=600000

            /****************************************************************************
             * SECTION: PROCESS COUNT                                                  *
            ****************************************************************************/

            // PREF: process count
            // [ABOUT] View in about:processes.
            // With Firefox Quantum (2017), CPU cores = processCount. However, since the
            // introduction of Fission [2], the number of website processes is controlled
            // by processCount.webIsolated. Disabling fission.autostart or changing
            // fission.webContentIsolationStrategy reverts control back to processCount.
            // [1] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/
            // [2] https://firefox-source-docs.mozilla.org/dom/ipc/process_model.html#web-content-processes
            user_pref("dom.ipc.processCount", 8); // DEFAULT; Shared Web Content
            user_pref("dom.ipc.processCount.webIsolated", 1); // default=4; Isolated Web Content

            // PREF: use one process for process preallocation cache
            user_pref("dom.ipc.processPrelaunch.fission.number", 1); // default=3; Process Preallocation Cache

            // PREF: configure process isolation
            // [1] https://hg.mozilla.org/mozilla-central/file/tip/dom/ipc/ProcessIsolation.cpp#l53
            // [2] https://www.reddit.com/r/firefox/comments/r69j52/firefox_content_process_limit_is_gone/

            // OPTION 1: isolate all websites
            // Web content is always isolated into its own `webIsolated` content process
            // based on site-origin, and will only load in a shared `web` content process
            // if site-origin could not be determined.
            //user_pref("fission.webContentIsolationStrategy", 1); // DEFAULT
            //user_pref("browser.preferences.defaultPerformanceSettings.enabled", true); // DEFAULT
            user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin

            // OPTION 2: isolate only "high value" websites
            // Only isolates web content loaded by sites which are considered "high
            // value". A site is considered high value if it has been granted a
            // `highValue*` permission by the permission manager, which is done in
            // response to certain actions.
            //user_pref("fission.webContentIsolationStrategy", 2);
            //user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
                //user_pref("dom.ipc.processCount.webIsolated", 1); // one process per site origin (high value)
                //user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors

            // OPTION 3: do not isolate websites
            // All web content is loaded into a shared `web` content process. This is
            // similar to the non-Fission behavior; however, remote subframes may still
            // be used for sites with special isolation behavior, such as extension or
            // mozillaweb content processes.
            //user_pref("fission.webContentIsolationStrategy", 0);
            //user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
            //user_pref("dom.ipc.processCount", 8); // determine by number of CPU cores/processors
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
