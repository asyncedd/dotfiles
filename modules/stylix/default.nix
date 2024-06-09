{pkgs, ...}: {
  imports = [
    ./themes/everblush.nix
    # ./themes/catppuccin.nix
  ];
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
      name = "Inter Medium";
    };
    serif = {
      package = pkgs.inter;
      name = "Inter Medium";
    };
  };
}
