{pkgs, ...}: let
  NewYork = pkgs.callPackage ../pkgs/fonts/NewYork/default.nix {inherit pkgs;};
in {
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      noto-fonts
      ubuntu_font_family
      unifont
      noto-fonts-cjk-sans
      maple-mono-NF
      nerdfonts
      freetype
      inter
      twitter-color-emoji
      NewYork
    ];

    fontconfig = {
      antialias = true;
      cache32Bit = true;
      hinting.enable = true;
      # hinting.autohint = true;
      defaultFonts = {
        serif = ["Inter"];
        sansSerif = ["Inter"];
        monospace = ["MapleMono"];
        emoji = ["Twemoji Color Emoji"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <edit mode="assign" name="antialias">       <bool>true</bool></edit>
          <edit mode="assign" name="hinting">         <bool>true</bool></edit>
          <edit mode="assign" name="hintstyle">       <const>hintmedium</const></edit>
          <edit mode="assign" name="lcdfilter">       <const>lcddefault</const></edit>
          <edit mode="assign" name="rgba">            <const>rgb</const></edit>

          <edit mode="assign" name="hintstyle"><const>hintnone</const></edit>
          <!-- Japanese -->
          <!-- "lang=ja" or "lang=ja-*" -->
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>ja</string>
            </test>
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="append" binding="strong">
              <string>Noto Serif CJK JP</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
