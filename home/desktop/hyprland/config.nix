{ config, ... }:

{
  imports = [
    ./config
  ];
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      exec = [
        "hyprctl setcursor phinger-cursors 24"
      ];
      exec-once = [
        "fcitx5 -r & nm-applet --indicator"
        "ags"
      ];
      monitor = ",highres,0x0,1,bitdepth,10";
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "escape:nocaps";
        kb_rules = "";

        follow_mouse = "1";

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        # "col.active_border" = "rgba(7ebae464)";
        "col.active_border" = "rgba(7ebae4ff)";
        "col.inactive_border" = "rgba(7ebae40A)";

        resize_on_border = true;

        layout = "dwindle";

        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
        };
        drop_shadow = false;

        dim_inactive = true;
      };

      animation = {
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"

          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];
        animation = [
          # "windows, 1, 6, wind, slide"
          # "windowsIn, 1, 6, winIn, slide"
          # "windowsOut, 1, 5, winOut, slide"
          # "windowsMove, 1, 5, wind, slide"
          # "border, 1, 1, liner"
          # "borderangle, 1, 30, liner, loop"
          # "fade, 1, 10, default"
          # "workspaces, 1, 5, wind"

          "windowsIn, 1, 1.7, easeOutCubic, slide" # window open
          "windowsOut, 1, 1.7, easeOutCubic, slide" # window close
          "windowsMove, 1, 2.5, easeinoutsine, slide" # everything in between, moving, dragging, resizing

          # fading
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 3, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 1, 5, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 5, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 6, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "workspaces, 1, 2, fluent_decel, slidefade" # styles: slide, slidevert, fade, slidefade, slidefadevert
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
        ];
      };

      misc = {
        force_default_wallpaper = 0;
        vrr = true;
        vfr = true;
      };
    };
    extraConfig = ''
      # will switch to a submap called resize
      bind=$mod,R,submap,resize
      
      # will start a submap called "resize"
      submap=resize
      
      # sets repeatable binds for resizing the active window
      binde = , l, resizeactive, 10 0
      binde = , h, resizeactive, -10 0
      binde = , k, resizeactive, 0 -10
      binde = , j, resizeactive, 0 10 
      # use reset to go back to the global submap
      bind=,escape,submap,reset 
      
      # will reset the submap, meaning end the current one and return to the global one
      submap=reset
    '';
  };
}
