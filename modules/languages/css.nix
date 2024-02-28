{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    prettierd
    nodePackages.vscode-css-languageserver-bin
  ];
}
