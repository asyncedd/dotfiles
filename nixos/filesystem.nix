{...}: {
  fileSystems."/".options = [
    "noatime"
    "discard"
  ];
}