{ pkgs, ... }:

{
  # gtk.font.package = with pkgs; udev-gothic-nf;
  # gtk.font.name = "UDEV Gothic NF";
  # qt.enable = true;
  # qt.style.name = "adwaita-dark";
  # gtk.enable = true;
  # gtk.theme.name = "Adwaita-dark";
  # fonts.fontconfig.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      ubuntu_font_family
      unifont
      noto-fonts-cjk-sans
      intel-one-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Intel One Mono" ];
      };
    };
  };

}
