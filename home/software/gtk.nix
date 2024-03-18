{pkgs, ...}: {
  qt = {
    enable = true;

    platformTheme = "gtk";

    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  gtk = {
    enable = true;

    gtk2 = {
      extraConfig = ''
        gtk-enable-animations=true
      '';
    };

    gtk3 = {
      extraConfig = {
        gtk-enable-animations = true;
      };
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    cursorTheme = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.phinger-cursors;
    name = "phinger-cursors";
    size = 28;
  };
}
