{ pkgs, ... }: rec {
  qt = {
    enable = true;

    platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.morewaita-icon-theme;
      name = "MoreWaita";
    };
  };

  home.packages = with pkgs; [
    gtk.iconTheme.package
    gnome.adwaita-icon-theme
    papirus-icon-theme
  ];
}
