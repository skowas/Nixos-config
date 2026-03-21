{ ... }:
{
  systemd.services.docker-cloudflared = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      RestartSec = "10s";
      Restart = "on-failure";
    };
  };
}