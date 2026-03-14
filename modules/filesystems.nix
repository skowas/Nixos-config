{ config, pkgs, ... }:

let
  user = "sko";
  uid = 1000;
  gid = 980;
in
{
  # Enable NTFS kernel driver
  boot.supportedFilesystems = [ "ntfs3" ];

fileSystems."/run/media/${user}/Data" = {
  device = "/dev/disk/by-uuid/64E42DDDE42DB1EA";
  fsType = "ntfs3";
  options = [
    "rw"
    "uid=${toString uid}"
    "gid=${toString gid}"
    "umask=022"
    "nofail"
    "force"
  ];
};

  fileSystems."/run/media/${user}/Windows-System" = {
    device = "/dev/disk/by-uuid/02E41662E416586D";
    fsType = "ntfs3";
    options = [
      "ro"          # safer for system partition
      "uid=${toString uid}"
      "gid=${toString gid}"
      "nofail"
    ];
  };

  fileSystems."/run/media/${user}/Windows-Data" = {
    device = "/dev/disk/by-uuid/0C7817F07817D774";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=${toString uid}"
      "gid=${toString gid}"
      "umask=022"
      "nofail"
    ];
  };
}
