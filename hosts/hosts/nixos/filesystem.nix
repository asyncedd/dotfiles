{ ... }:

{
  fileSystems."/".options = [
    "noatime"
    "discard"
    "journal_async_commit"
    "data=journal"
  ];
}
