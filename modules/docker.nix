{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  users.users.sko.extraGroups = [ "docker" ];
}
