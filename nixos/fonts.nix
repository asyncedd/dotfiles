{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      ubuntu_font_family
      unifont
      noto-fonts-cjk-sans
      maple-mono-autohint
      noto-fonts-emoji
      nerdfonts
      freetype
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "MapleMono" ];
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
        </fontconfig>
      '';
    };
  };

}
