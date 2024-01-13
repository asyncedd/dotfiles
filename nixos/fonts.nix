{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      ubuntu_font_family
      unifont
      noto-fonts-cjk-sans
      intel-one-mono
      noto-fonts-emoji
      nerdfonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Intel One Mono" ];
      };
      localConf = ''
        <match target="font">
          <edit name="autohint" mode="assign">
            <bool>true</bool>
          </edit>
        </match>
        <match target="font">
          <edit name="hintstyle" mode="assign">
            <const>hintnone</const>
          </edit>
        </match>
        <match target="font">
          <edit name="rgba" mode="assign">
            <const>rgb</const>
          </edit>
        </match>
        <match target="font">
          <edit name="lcdfilter" mode="assign">
            <const>lcddefault</const>
          </edit>
        </match>
      '';
    };
  };

}
