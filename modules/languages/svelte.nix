{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodePackages.svelte-language-server
    prettierd
    emmet-ls
    tailwindcss-language-server
  ];
}
