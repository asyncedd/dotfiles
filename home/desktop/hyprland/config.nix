{ config, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      monitor = ",preferred,auto,1";
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
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
        rounding = 20;
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

      dwindle = {
        no_gaps_when_only = false;
        pseudotile = true; 
        smart_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
      };
      bindm = 
        [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      bind =
        [
          "$mod, Q, killactive"
          "$mod, T, exec, kitty"
          "$mod, J, togglesplit"
          "$mod, P, pseudo"
          "$mod, F, exec, firefox"
          "$mod, V, togglefloating,"
          "$mod, M, exit"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          "$mod, H, exec, grim -g \"$(slurp)\" - | swappy -f -"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ 
        (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
              )
          10)
        );
    };
  };
}
