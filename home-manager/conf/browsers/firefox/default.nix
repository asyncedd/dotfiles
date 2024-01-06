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
	search.default = "DuckDuckGo";
	extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
	  ublock-origin
	  skip-redirect
	  sidebery
          h264ify
	];
	extraConfig = userJS;
        userChrome = ''
          #sidebar-box *,
          #urlbar-background,
          #navigator-toolbox {
            transition: background-color 10s cubic-bezier(0, 0, 0, 1);
          }
          .tab-background {
            transition: background-color 10s cubic-bezier(0, 0, 0, 1);
            box-shadow: none !important;
            background-image: none !important;
          }
          .tab-background[selected] {
            background-color: var(--tab-selected-bgcolor) !important;
          }
        '';
      };
    };
  };
}
