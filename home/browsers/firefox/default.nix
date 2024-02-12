{ config, pkgs, inputs, lib, outputs, ... }:
  let
    engines = {
      "Brave" = {
        urls = [{
          template = "https://search.brave.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.fetchurl {
          url = "https://cdn.search.brave.com/serp/v2/_app/immutable/assets/brave-search-icon.rCBTNmje.svg";
          sha256 = "sha256-Y56N3DuSdJyVQ16TV8zany5CBw75O6oPRkOq0BWyljI=";
        }}";
        definedAliases = [ "@b" ];
      };

      "Wikipedia (en)".metaData.alias = "@wiki";
      "Google".metaData.hidden = true;
      "Amazon.com".metaData.hidden = true;
      "Amazon.co.jp".metaData.hidden = true;
      "Bing".metaData.hidden = true;
      "eBay".metaData.hidden = true;
    }; 
    userChrome = ''
      /* @import "${inputs.lepton}/userChrome.css"; */
      /* @import "${inputs.firefox-csshacks}/chrome/hide_tabs_toolbar.css"; */
      @import "${inputs.firefox-csshacks}/chrome/centered_statuspanel.css";
      /* @import "${inputs.firefox-csshacks}/chrome/window_control_placeholder_support.css"; */
      /* @import "${inputs.edge-frfox}/chrome/userChrome.css"; */
      /* @import "${./userChrome}/macos_buttons.css"; */
      /* @import "${./userChrome}/urlbar.css"; */
      @import "${inputs.firefox-mod-blur}/userChrome.css";
      @import "${inputs.firefox-mod-blur}/EXTRA MODS/Min-max-close control buttons/Left side MacOS style buttons/min-max-close_buttons.css";
      
      #sidebar-header,
      #sidebar-splitter {
          display: none !important;
      }

      #titlebar{
        will-change: unset !important;
        transition: none !important;
        opacity: 1 !important;
        padding: 0px !important;
        margin: 0px !important;
      }
      #TabsToolbar{ visibility: collapse !important } 

      #appcontent
      > #tabbrowser-tabbox
      > #tabbrowser-tabpanels
      > .deck-selected
      > .browserContainer
      > .browserStack
      > browser {
        border-radius: 7px !important;
        margin: 6px !important;
        outline: 5px solid var(--lwt-frame) !important;
        box-shadow: rgba(0, 0, 0, 0.16) 6px 6px 6px 6px !important;
      }
    '';
    userContent = ''
      @import "${inputs.edge-frfox}/chrome/userContent.css";
      @import "${inputs.lepton}/chrome/userContent.css";
      @import "${inputs.firefox-mod-blur}/userContent.css";
    '';
    smoothScrolling = ''
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
    '';
    search = {
      force = true;
      default = "Brave";
      privateDefault = "Brave";
      order = [ "Brave" "DuckDuckGo" ];
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
          (builtins.readFile "${inputs.lepton}/user.js")
          (builtins.readFile "${inputs.edge-frfox}/user.js")
          smoothScrolling
          ''
            // Better fonts
            user_pref("gfx.font_rendering.cleartype_params.cleartype_level", 100);
            user_pref("gfx.font_rendering.cleartype_params.enhanced_contrast", 50);
            user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "");
            user_pref("gfx.font_rendering.cleartype_params.pixel_structure", 1);
            user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);
            user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);

           user_pref("browser.startup.page", 3); // 0102
           // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
           // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
           user_pref("privacy.clearOnShutdown.history", false); // 2811
           // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

           user_pref("network.trr.mode", 3);
           user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
        ''];
        inherit userChrome userContent;
      };
      profiles.anon = {
        id = 1;
        name = "anon";
        isDefault = false;
        inherit search;
	extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          (builtins.readFile "${inputs.lepton}/user.js")
          (builtins.readFile "${inputs.edge-frfox}/user.js")
          smoothScrolling
          ''
            // Better fonts
            user_pref("gfx.font_rendering.cleartype_params.cleartype_level", 100);
            user_pref("gfx.font_rendering.cleartype_params.enhanced_contrast", 50);
            user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "");
            user_pref("gfx.font_rendering.cleartype_params.pixel_structure", 1);
            user_pref("gfx.font_rendering.cleartype_params.rendering_mode", 5);
            user_pref("gfx.webrender.quality.force-subpixel-aa-where-possible", true);

           user_pref("browser.startup.page", 3); // 0102
           // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
           // user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
           user_pref("privacy.clearOnShutdown.history", false); // 2811
           // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

           user_pref("network.trr.mode", 3);
           user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");

        ''];
        inherit userChrome userContent;
      };
      profiles.arkenfox = {
        id = 2;
        name = "arkenfox";
        isDefault = false;
        inherit search;
	extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.arkenfox}/user.js")
          (builtins.readFile "${inputs.lepton}/user.js")
          (builtins.readFile "${inputs.edge-frfox}/user.js")
        ];
        inherit userChrome userContent;
      };
    };
  };
}
