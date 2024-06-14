{pkgs, ...}: {
  imports = [
    ./zsh
    ./tools/zoxide
    ./tools/fzf
    ./tools/gitui.nix
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

  programs.btop.enable = true;
}
