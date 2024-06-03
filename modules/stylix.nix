{
  userConfig,
  pkgs,
  ...
}: {
  stylix.polarity = "dark";
  stylix.base16Scheme = {
    base00 = "#141b1e";
    base01 = "#1e2528";
    base02 = "#282f32";
    base03 = "#2d3437";
    base04 = "#3c4346";
    base05 = "#dadada";
    base06 = "#e4e4e4";
    base07 = "#dadada";
    base08 = "#e57474";
    base09 = "#fcb163";
    base0A = "#e5c76b";
    base0B = "#8ccf7e";
    base0C = "#6cbfbf";
    base0D = "#67b0e8";
    base0E = "#c47fd5";
    base0F = "#ef7d7d";
  };
  stylix.image = userConfig.wallpaper;

  stylix.cursor = {
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 24;
  };

  stylix.fonts.emoji = {
    package = pkgs.twitter-color-emoji;
    name = "TwitterColorEmoji";
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.maple-mono-NF;
      name = "MapleMono NF";
    };
    sansSerif = {
      package = pkgs.inter;
      name = "InterVariable";
    };
    serif = {
      package = pkgs.inter;
      name = "InterVariable";
    };
  };
}
