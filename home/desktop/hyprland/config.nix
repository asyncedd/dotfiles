{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      exec = [
        "hyprctl setcursor phinger-cursors 24"
        "swww init"
      ];
      exec-once = [
        "fcitx5 -r & nm-applet --indicator"
        "ags -b hypr"
      ];
      monitor = ",highres,0x0,1,bitdepth,10";
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
        gaps_out = 5;
        border_size = 0;

        resize_on_border = true;

        layout = "dwindle";

        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          noise = "0.07";
          contrast = "0.7";
          brightness = "1.0";
          vibrancy = "0.6";
          vibrancy_darkness = "0.5";
          size = 30;
          passes = 3;
          xray = true;
          popups = true;
          ignore_opacity = false;
          new_optimizations = true;
        };
        drop_shadow = false;

        dim_inactive = true;
      };

      gestures = {
        workspace_swipe = true;
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

          "windowsIn, 1, 3, easeOutCubic, slide" # window open
          "windowsOut, 1, 3, easeOutCubic, slide" # window close
          "windowsMove, 1, 3.5, easeinoutsine, slide" # everything in between, moving, dragging, resizing

          # fading
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 3, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 1, 5, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 5, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 6, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "borderangle, 1, 60, easeOutCirc, loop" # for animating the border's color switch speed
          "workspaces, 1, 3, fluent_decel, slidefade" # styles: slide, slidevert, fade, slidefade, slidefadevert
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
        ];
      };

      misc = {
        force_default_wallpaper = 0;
        vrr = true;
        vfr = true;
      };
      layerrule = [
        "blur,bar-0"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        ws = binding "SUPER" "workspace";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        e = "exec, ags -b hypr";
        arr = [1 2 3 4 5 6 7 8 9];
      in
        [
          "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
          "SUPER, R,       ${e} -t launcher"
          "SUPER, S,       exec, ${pkgs.grimblast}/bin/grimblast copysave area"
          "SUPER, C, exec, swaylock --screenshots --clock --grace 1 --fade-in 1 --effect-blur 7x5 --effect-vignette 0.5:0.5"
          ",XF86Launch4,   ${e} -r 'recorder.start()'"
          ",Print,         ${e} -r 'recorder.screenshot()'"
          "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
          "SUPER, Tab,     ${e} -t overview"
          ",XF86PowerOff,  ${e} -r 'powermenu.shutdown()'"
          "SUPER, Return, exec, kitty" # xterm is a symlink, not actually xterm
          "SUPER, W, exec, firefox"
          "SUPER, E, exec, kitty -e yazi"

          # "ALT, Tab, focuscurrentorlast"
          # "CTRL ALT, Delete, exit"
          "SUPER, Q, killactive"
          "SUPER, F, togglefloating"
          "SUPER, G, fullscreen"
          "SUPER, O, fakefullscreen"
          "SUPER, P, togglesplit"

          "SUPER, k, movefocus, u"
          "SUPER, j, movefocus, d"
          "SUPER, l, movefocus, r"
          "SUPER, h, movefocus, l"

          "SUPER, left, workspace, e-1"
          "SUPER, right, workspace, e+1"

          "SUPER SHIFT, left, movetoworkspace, e-1"
          "SUPER SHIFT, right, movetoworkspace, e+1"

          "SUPER SHIFT, left, workspace, e-1"
          "SUPER SHIFT, right, workspace, e+1"

          "SUPER CTRL, k, moveactive, 0 -20"
          "SUPER CTRL, j, moveactive, 0 20"
          "SUPER CTRL, l, moveactive, 20 0"
          "SUPER CTRL, h, moveactive, -20 0"

          "SUPER ALT, k, resizeactive, 0 -20"
          "SUPER ALT, j, resizeactive, 0 20"
          "SUPER ALT, l, resizeactive, 20 0"
          "SUPER ALT, h, resizeactive, -20 0"
        ]
        # ++ (map (i: ws (toString i) (toString i)) arr)
        # ++ (map (i: mvtows (toString i) (toString i)) arr);
        ++ (
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
                "$mod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
    # extraConfig = ''
    #   # will switch to a submap called resize
    #   bind=$mod,R,submap,resize
    #
    #   # will start a submap called "resize"
    #   submap=resize
    #
    #   # sets repeatable binds for resizing the active window
    #   binde = , l, resizeactive, 10 0
    #   binde = , h, resizeactive, -10 0
    #   binde = , k, resizeactive, 0 -10
    #   binde = , j, resizeactive, 0 10
    #   # use reset to go back to the global submap
    #   bind=,escape,submap,reset
    #
    #   # will reset the submap, meaning end the current one and return to the global one
    #   submap=reset
    #
    # '';
  };
}
