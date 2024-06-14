{osConfig, ...}: {
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "10";
      window_margin_width = "10";
      enable_audio_bell = false;
      update_check_interval = 0;
      cursor_blink_interval = 0;
    };
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
      undercurl_style thick-dense
      modify_font underline_thickness 150%
      modify_font underline_position 2

      symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font

      font_features MapleMono-Regular +cv01 +cv02 +ss01 +ss02 -ss03 +ss04 +ss05 -liga
      disable_ligatures cursor
    '';
  };
}
