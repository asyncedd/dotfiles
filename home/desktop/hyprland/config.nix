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
        border_size = 0;

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
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
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
