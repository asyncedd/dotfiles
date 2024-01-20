{ config, pkgs, inputs, lib, outputs, ... }:
  let
    engines = {
      "GitHub" = {
        url = [{
          template = "https://github.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.fetchurl {
          url = "https://github.githubassets.com/favicons/favicon.svg";
          sha256 = "sha256-apV3zU9/prdb3hAlr4W5ROndE4g3O1XMum6fgKwurmA=";
        }}";
        definedAliases = [ "@gh" ];
      };

      "Reddit" = {
        urls = [{
          template = "https://www.reddit.com/search";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.fetchurl {
          url = "https://www.redditstatic.com/accountmanager/favicon/favicon-512x512.png";
          sha256 = "sha256-4zWTcHuL1SEKk8KyVFsOKYPbM4rc7WNa9KrGhK4dJyg=";
        }}";
        definedAliases = [ "@r" ];
      };

      "Youtube" = {
        urls = [{
          template = "https://www.youtube.com/results";
          params = [{ name = "search_query"; value = "{searchTerms}"; }];
        }];
        icon = "${pkgs.fetchurl {
          url = "www.youtube.com/s/desktop/8498231a/img/favicon_144x144.png";
          sha256 = "sha256-lQ5gbLyoWCH7cgoYcy+WlFDjHGbxwB8Xz0G7AZnr9vI=";
        }}";
        definedAliases = [ "@y" ];
      };
    }; 
    userChrome = ''
      @import "${inputs.lepton}/chrome/userChrome.css";
      /** @import "${inputs.firefox-csshacks}/chrome/hide_tabs_toolbar.css"; **/
      /** @import "${inputs.firefox-csshacks}/chrome/window_control_placeholder_support.css"; **/
      @import "${inputs.edge-frfox}/chrome/userChrome.css";
      
      #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] > #sidebar-header{
        display: none
      }

      #sidebar,
      #sidebar-header{
        background-color: inherit !important;
        border-inline: none !important;
      }
    '';
    userContent = ''
      @import "${inputs.edge-frfox}/chrome/userContent.css";
      @import "${inputs.lepton}/chrome/userContent.css";
    '';
  in {
  programs = {
    firefox = {
      enable = true;
      policies = { 
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = true;
        DisableProfileImport = true;
        DisableSetDesktopBackground = true;
        DisableFeedbackCommands = true;
        DisableFirefoxScreenshots = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        PasswordManagerEnabled = false;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
          TopSites = false;
          Highlights = false;
          Locked = true;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
        Cookies = {
          Behavior = "accept";
          Locked = false;
        };
        Extensions = {
          Uninstall = [
             "google@search.mozilla.org"
             "bing@search.mozilla.org"
             "amazondotcom@search.mozilla.org"
             "ebay@search.mozilla.org"
             "twitter@search.mozilla.org"
          ];
        };
        SearchEngines = {
          Remove = [
            "Google"
            "Bing"
            "Amazon.com"
            "eBay"
            "Twitter"
          ];
        };
      };
      profiles.async = {
        id = 0;
        name = "async";
        isDefault = true;
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
          inherit engines;
        };
	extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
	  ublock-origin
	  sidebery

          re-enable-right-click
          don-t-fuck-with-paste

          sponsorblock
          return-youtube-dislikes

          enhanced-github
          refined-github
          github-file-icons

          duckduckgo-privacy-essentials

          bypass-paywalls-clean
          raindropio
          darkreader
	];
	extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.betterfox}/user.js")
          (builtins.readFile "${inputs.lepton}/user.js")
          (builtins.readFile "${inputs.edge-frfox}/user.js")
          ''
            // Smooth scrolling
            user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
            user_pref("general.smoothScroll", true); // DEFAULT
            user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
            user_pref("general.smoothScroll.msdPhysics.enabled", true);
            user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
            user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", 2.0);
            user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
            user_pref("general.smoothScroll.currentVelocityWeighting", 1.0);
            user_pref("general.smoothScroll.stopDecelerationWeighting", 1.0);
            user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking

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


          ''
        ];
        inherit userChrome userContent;
      };
      profiles.anom = {
        id = 1;
        name = "anom";
        isDefault = false;
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
          inherit engines;
        };
	extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
	  ublock-origin
	  skip-redirect
	  sidebery
          enhanced-h264ify
	];
	extraConfig = lib.strings.concatStrings [
          (builtins.readFile "${inputs.arkenfox}/user.js")
          (builtins.readFile "${inputs.lepton}/user.js")
          (builtins.readFile "${inputs.edge-frfox}/user.js")
          ''
            /* override recipe: enable session restore ***/
            user_pref("browser.startup.page", 3); // 0102
              // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
            user_pref("privacy.clearOnShutdown.history", false); // 2811
              // user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

            // homepage
            user_pref("browser.startup.homepage", "about:home");
            user_pref("browser.newtabpage.enabled", true);
            user_pref("browser.startup.page", 1);
          
            // disable the "master switch" that disables about:home
            //user_pref("browser.startup.homepage_override.mstone", "");
          
            // allow search engine searching from the urlbar
            user_pref("keyword.enabled", true);
          
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          
            user_pref("privacy.resistFingerprinting.letterboxing", false);
          
            // DRM content :(
            user_pref("media.gmp-widevinecdm.enabled", true);
            user_pref("media.eme.enabled", true);
          
            user_pref("browser.startup.page", 3);
            user_pref("privacy.clearOnShutdown.history", false);
          
            // Enable CSD
            user_pref("browser.tabs.drawInTitlebar", true);
          
            // Set UI density to normal
            user_pref("browser.uidensity", 0);

            user_pref("browser.formfill.enable", true);
            user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
