{pkgs, ...}: {
  programs.neovim = {
    package = pkgs.neovim;
    enable = true;
  };
}
