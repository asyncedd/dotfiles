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

      "Nix Packages" = {
        urls = [{
          template = "https://search.nixos.org/packages";
          params = [
            { name = "channel"; value = "unstable"; }
            { name = "query"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@npu" ];
      };

      "NixOS Wiki" = {
        urls = [{
          template = "https://nixos.wiki/index.php";
          params = [{ name = "search"; value = "{searchTerms}"; }];
        }];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@nw" ];
      };

      "Nixpkgs Issues" = {
        urls = [{
          template = "https://github.com/NixOS/nixpkgs/issues";
          params = [
            { name = "q"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@ni" ];
      };


      "Mojeek" = {
        urls = [{
	  template = "https://www.mojeek.com/search";
	  params = [
	    { name = "q"; value = "{searchTerms}"; }
	    { name = "qss"; value = "Bing,Brave,DuckDuckGo,Ecosia,Google,Qwant,Startpage,Swisscows"; }
	    { name = "theme"; value = "dark"; }
          ];
	}];
	icon = "${pkgs.fetchurl {
	  url = "https://www.mojeek.com/favicon.ico";
	  sha256 = "sha256-KaqltNCw9h+QkCx9C3MTJt6Z7pMbtVmYys+oG6YLv5M=";
	}}";
	definedAliases = [ "@m" ];
      };

      "Urban Dictionary" = {
        urls = [{
          template = "https://www.urbandictionary.com/define.php";
          params = [
            { name = "term"; value = "{searchTerms}"; }
          ];
        }];
        icon = "${pkgs.fetchurl {
          url = "https://www.urbandictionary.com/favicon.ico";
          sha256 = "sha256-JVdGocDJfuRr1d/An9Ba1jHiKlWF+tf0+i9Yz4OdIiA=";
        }}";
        definedAliases = [ "@ub" ];
      };

      "Wikipedia (en)".metaData.alias = "@wiki";
      "Google".metaData.hidden = true;
      "Amazon.com".metaData.hidden = true;
      "Amazon.co.jp".metaData.hidden = true;
      "Bing".metaData.hidden = true;
      "eBay".metaData.hidden = true;
    }; 
    userChrome = ''
      @import "${inputs.lepton}/userChrome.css";
      @import "${inputs.firefox-csshacks}/chrome/hide_tabs_toolbar.css";
      @import "${inputs.firefox-csshacks}/chrome/centered_statuspanel.css";
      /* @import "${inputs.firefox-csshacks}/chrome/window_control_placeholder_support.css"; */
      /* @import "${inputs.edge-frfox}/chrome/userChrome.css"; */
      @import "${./userChrome}/macos_buttons.css";
      @import "${./userChrome}/urlbar.css";
      
      #sidebar-header,
      #sidebar-splitter {
          display: none !important;
      }

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
    '';
  in {
  imports = [
    ./addons/ublock.nix
  ];
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
          Install = [
            "https://addons.mozilla.org/firefox/downloads/file/4210197/youtube_recommended_videos-1.6.3.xpi" # Unhook
            "https://addons.mozilla.org/firefox/downloads/file/4216633/ublock_origin-1.55.0.xpi" # Ublock origin
            "https://github.com/mbnuqw/sidebery/releases/download/v5.0.0/sidebery-5.0.0.1.xpi" # Sidebery
            "https://addons.mozilla.org/firefox/downloads/file/3981363/re_enable_right_click-0.5.4.xpi" # Re-Enable right click
            "https://addons.mozilla.org/firefox/downloads/file/4202411/sponsorblock-5.4.29.xpi" # SponsorBlock
            "https://addons.mozilla.org/firefox/downloads/file/4208483/return_youtube_dislikes-3.0.0.14.xpi" # Return Youtube Dislike
            "https://addons.mozilla.org/firefox/downloads/file/3764141/enhanced_github-5.0.11.xpi" # Enhanced Github
            "https://addons.mozilla.org/firefox/downloads/file/4156831/github_file_icons-1.5.1.xpi" # Github File Icons
            "https://addons.mozilla.org/firefox/downloads/file/4219626/refined_github-24.1.10.xpi" # Redefined Github
            "https://gitlab.com/magnolia1234/bpc-uploads/-/raw/master/bypass_paywalls_clean-latest.xpi" # Bypass Paywalls Clean
            "https://addons.mozilla.org/firefox/downloads/file/4198542/raindropio-6.6.19.xpi" # Raindrop.io
            "https://addons.mozilla.org/firefox/downloads/file/4220708/darkreader-4.9.75.xpi" # Darkreader
            "https://addons.mozilla.org/firefox/downloads/file/4218010/keepassxc_browser-1.8.11.xpi" # KeePassXC Browser
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
        name = "anon";
        isDefault = false;
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
          inherit engines;
        };
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

            /* 2801: delete cookies and site data on exit
             * 0=keep until they expire (default), 2=keep until you close Firefox
             * [SETTING] Privacy & Security>Cookies and Site Data>Delete cookies and site data when Firefox is closed
             * [SETTING] to add site exceptions: Ctrl+I>Permissions>Cookies>Allow
             *   If using FPI the syntax must be https://example.com/^firstPartyDomain=example.com
             * [SETTING] to manage site exceptions: Options>Privacy & Security>Permissions>Settings ***/
            user_pref("network.cookie.lifetimePolicy", 2);
            
            /* override recipe: enable session restore ***/
            user_pref("browser.startup.page", 3); // 0102
            // user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
            // user_pref("places.history.enabled", true); // 0862 required if you had it set as false
            user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional [to restore cookies/formdata]
            // user_pref("network.cookie.lifetimePolicy", 0); // 2801 [don't: add cookie + site data exceptions instead]
            user_pref("privacy.clearOnShutdown.history", false); // 2811
            // user_pref("privacy.clearOnShutdown.cookies", false); // 2811 optional: default false arkenfox v94
            // user_pref("privacy.clearOnShutdown.formdata", false); // 2811 optional
            user_pref("privacy.cpd.history", false); // 2812 to match when you use Ctrl-Shift-Del
            // user_pref("privacy.cpd.cookies", false); // 2812 optional: default false arkenfox v94
            // user_pref("privacy.cpd.formdata", false); // 2812 optional
          ''
        ];
        inherit userChrome userContent;
      };
    };
  };
}
