{pkgs, ...}: {
  home.packages = [pkgs.libsixel];
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "MapleMono NF:size=7.5:fontfeatures=calt:fontfeatures=dlig:fontfeatures=liga";
        box-drawings-uses-font-glyphs = "yes";
        dpi-aware = "yes";
        pad = "25x25center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "clipboard";
      };
    };
  };
}
