{
  pkgs,
  config,
  ...
}: rec {
  qt = {
    enable = true;

    platformTheme = "gtk";

    style = {
      package = pkgs.adwaita-qt;
      name = "adw-gtk3";
    };
  };

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 24;
  };

  home.packages = [
    home.pointerCursor.package
    gtk.theme.package
    gtk.iconTheme.package
  ];
}
