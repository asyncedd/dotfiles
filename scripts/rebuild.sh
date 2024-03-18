set -e
alejandra . &>/dev/null
git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake ~/dotfiles/ &>nixos-switch.log || (
cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations --flake . | grep current)
git commit -am "$gen"
popd
