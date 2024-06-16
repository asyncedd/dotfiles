{ pkgs, ... }: {
  programs.neovim = {
    package = pkgs.neovim;
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
