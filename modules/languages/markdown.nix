{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    marksman
    prettierd
  ];
}
