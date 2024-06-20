{ pkgs, ... }:
{
  imports = [
    ./themes/everblush.nix
    # ./themes/decay.nix
    # ./themes/evergarden.nix
    # ./themes/catppuccin.nix
  ];
  stylix.cursor = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir";
    size = 24;
  };

  stylix.fonts.emoji = {
    package = pkgs.twitter-color-emoji;
    name = "TwitterColorEmoji";
  };

  stylix.fonts = {
    monospace = {
      package = pkgs.maple-mono-autohint;
      name = "Maple Mono";
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
