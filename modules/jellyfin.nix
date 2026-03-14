{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # Give jellyfin access to your NTFS media drives (gid 980 = sko group)
  users.users.jellyfin.extraGroups = [ "sko" ];
}