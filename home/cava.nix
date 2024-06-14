{osConfig, ...}: let
  colors = osConfig.lib.stylix.colors;
in {
  programs.cava.enable = true;
  programs.cava.settings = {
    color = {
      gradient = "1";
      gradient_count = "7";

      gradient_color_1 = " '#${colors.base0F}'";
      gradient_color_2 = " '#${colors.base0E}'";
      gradient_color_3 = " '#${colors.base0D}'";
      gradient_color_4 = " '#${colors.base0C}'";
      gradient_color_5 = " '#${colors.base0B}'";
      gradient_color_6 = " '#${colors.base0A}'";
      gradient_color_7 = " '#${colors.base09}'";
    };
    smoothing = {
      waves = "1";
    };
  };
}
