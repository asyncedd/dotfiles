{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  home.packages = [pkgs.libsixel];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "25x25center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        font = lib.mkForce "${osConfig.stylix.fonts.monospace.name}:size=10, Symbols Nerd Font Mono:size=10:charset=${lib.concatMapStrings (x: x + " ") [
          "e000-e00a ea60-ebeb e0a0-e0c8 e0ca e0cc-e0d4 e200-e2a9 e300-e3e3 e5fa-e6b1 e700-e7c5 f000-f2e0 f300-f372 f400-f532 f0001-f1af0 "
        ]}";
        # selection-target = "clipboard";
        # box-drawings-uses-font-glyphs = "yes";
        # dpi-aware = lib.mkForce "yes";
        # pad = "10x10center";
        term = "xterm-256color";
        vertical-letter-offset = "-0.90";
      };
      cursor = {
        color = "${colors.base06} ${colors.base07}";
        # style = "beam";
        # beam-thickness = "2";
      };
    };
  };
}
