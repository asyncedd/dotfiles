{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;
    };
  };

  programs.zsh.initExtra = ''
    eval "$(starship init zsh)"
  '';

}
