{pkgs, ...}: {
  environment.shells = with pkgs; [nushell];
  users.defaultUserShell = pkgs.nushell;
  # programs.zsh.enable = true;
  # programs.nushell.enable = true;
}
