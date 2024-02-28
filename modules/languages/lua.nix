{ pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
    stylua
    lua-language-server
  ];
}
