{ config, pkgs, inputs, lib, ... }:
  let
    userJS = lib.strings.concatStrings [
      (builtins.readFile "${inputs.betterfox}/user.js")
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
  in {
  programs = {
    firefox = {
      enable = true;
      profiles.async = {
        id = 0;
        name = "async";
        isDefault = true;
        search = {
          force = true;
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          order = [ "DuckDuckGo" "Google" ];
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
        };
	extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
	  ublock-origin
	  skip-redirect
	  sidebery
          h264ify
	];
	extraConfig = userJS;
        userChrome = ''
          @import "${inputs.firefox-csshacks}/chrome/hide_tabs_toolbar.css";
          @import "${inputs.firefox-csshacks}/chrome/window_control_placeholder_support.css";
          
          #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] > #sidebar-header{
            display: none
          }

          #sidebar,
          #sidebar-header{
            background-color: inherit !important;
            border-inline: none !important;
          }
        '';
      };
    };
  };
}
