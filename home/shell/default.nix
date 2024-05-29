{pkgs, ...}: {
  imports = [
    ./zsh
    ./tools/zoxide
    ./tools/fzf
    # ./prompts/starship
  ];

  home.packages = with pkgs; [
    eza
    bat
    tldr
    duf
    pipes
    cbonsai
  ];
}
