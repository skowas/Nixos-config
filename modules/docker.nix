# modules/docker.nix
{ ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon.settings = {
      dns = [ "8.8.8.8" "1.1.1.1" ];
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";

   containers.cloudflared = {
  image = "cloudflare/cloudflared:latest";
  autoStart = true;
  extraOptions = [ "--network=host" ];
  cmd = [
    "tunnel"
    "--no-autoupdate"
    "run"
    "--token"
    "eyJhIjoiZTEzMDU2YzZiMjZjM2MxNmM2NDc3MWIzOWJmMjYxMDYiLCJ0IjoiNjkyOWVmNWQtZmVjMC00MGI0LTg4NjItMTlhZTg4MWQ2NzBmIiwicyI6Ik9EbGhaVFpoTm1FdE5qTXlOaTAwT1dSakxXSmhNR1V0WlRGa05qa3pNMlF6TVdKaCJ9"
  ];
};

    containers.synchronet = {
      image = "bbsio/synchronet:latest";
      autoStart = true;
      extraOptions = [ "--user=0:0" ];
      ports = [
        "23:23"
        "2222:22"
        "8080:80"
        "6667:6667"
        "6697:6697"
      ];
      volumes = [
        "/persist/synchronet/sbbs-data:/sbbs-data"
        "/persist/synchronet/data:/sbbs/data"
        "/persist/synchronet/ctrl:/sbbs/ctrl"
        "/persist/synchronet/text:/sbbs/text"
        "/persist/synchronet/mods:/sbbs/mods"
        "/persist/synchronet/web:/sbbs/web"
        "/persist/synchronet/logs:/sbbs/logs"
      ];
      environment = {
        SBBSCTRL = "/sbbs/ctrl";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    23
    2222
    8080
    6667
    6697
  ];

  users.users.sko.extraGroups = [ "docker" ];
}
