{
  programs.kitty = {
    enable = true;
    settings = {
      window_margin_width = "5";
      enable_audio_bell = false;
      update_check_interval = 0;
      cursor_blink_interval = 0;
    };
    theme = "One Dark";
    shellIntegration.enableZshIntegration = true;
  };
}
