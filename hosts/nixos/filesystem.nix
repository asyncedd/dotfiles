{ ... }:

{
  fileSystems."/".options = [
    "noatime"
    "discard"
  ];
}
