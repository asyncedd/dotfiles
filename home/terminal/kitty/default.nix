{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "10";
      window_margin_width = "5";
      enable_audio_bell = false;
      update_check_interval = 0;
      cursor_blink_interval = 0;
    };
    theme = "One Dark";
    font.name = "MapleMono";
    shellIntegration.enableZshIntegration = true;
    extraConfig = ''
            undercurl_style thick-dense
         modify_font underline_thickness 150%
      modify_font underline_position 2

              # Seti-UI + Custom
              symbol_map U+E5FA-U+E6AC Symbols Nerd Font

              # Devicons
              symbol_map U+E700-U+E7C5 Symbols Nerd Font

              # Font Awesome
              symbol_map U+F000-U+F2E0 Symbols Nerd Font

              # Font Awesome Extension
              symbol_map U+E200-U+E2A9 Symbols Nerd Font

              # Material Design Icons
              symbol_map U+F0001-U+F1AF0 Symbols Nerd Font

              # Weather
              symbol_map U+E300-U+E3E3 Symbols Nerd Font

              # Octicons
              symbol_map U+F400-U+F532,U+2665,U+26A1 Symbols Nerd Font

              # Powerline Symbols
              symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font

              # Powerline Extra Symbols
              symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4 Symbols Nerd Font

              # IEC Power Symbols
              symbol_map U+23FB-U+23FE,U+2B58 Symbols Nerd Font

              # Font Logos
              symbol_map U+F300-U+F32F Symbols Nerd Font

              # Pomicons
              symbol_map U+E000-U+E00A Symbols Nerd Font

              # Codicons
              symbol_map U+EA60-U+EBEB Symbols Nerd Font

              # Additional sets
              symbol_map U+E276C-U+E2771 Symbols Nerd Font # Heavy Angle Brackets
              symbol_map U+2500-U+259F Symbols Nerd Font # Box Drawing
    '';
  };
}
