{pkgs, ...}: rec {
  qt = {
    enable = true;

    platformTheme = "gtk";
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  home.packages = [
    gtk.iconTheme.package
  ];
}
