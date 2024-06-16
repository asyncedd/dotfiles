{ osConfig, ... }:
let colors = osConfig.lib.stylix.colors;
in {
  programs.cava.enable = true;
  programs.cava.settings = {
    color = {
      background = "default";
      foreground = "'#${colors.base0D}'";
    };
  };
}
