{...}: {
  fileSystems."/".options = [
    "noatime"
    "discard"
  ];
}
