{ ... }:

{
  wayland.windowManager.hyprland.settings = {
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

        "$mod, N, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mod, L, exec, swaylock --screenshots --clock --grace 2 --fade-in 1 --effect-blur 7x5 --effect-vignette 0.5:0.5"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        "$mod, G, togglegroup"
        "$mod, TAB, changegroupactive"
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
              "$mod CTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}"
            ]
            )
        10)
      );
  };
}
