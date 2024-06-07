{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        enable_wayland = true,
      }
    '';
  };
}
