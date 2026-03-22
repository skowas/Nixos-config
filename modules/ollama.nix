{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;  # ← replaces acceleration = "cuda"
    environmentVariables = {
      OLLAMA_ORIGINS = "*";
    };
  };

  services.open-webui = {
    enable = true;
    port = 8081;
    environment = {
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
      WEBUI_AUTH = "false";
    };
  };

  networking.firewall.allowedTCPPorts = [ 11434 8081 ];
}