{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/bluetooth.nix
    ./modules/filesystems.nix
    ./modules/users.nix
    ./modules/boot.nix
    ./modules/networking.nix
    ./modules/locale.nix
    ./modules/nvidia.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/nushell.nix
    ./modules/docker.nix
    ./modules/services.nix
    ./modules/gaming.nix
    ./modules/jellyfin.nix
    ./modules/packages.nix
    ./modules/star-citizen.nix
    ./modules/ssh.nix       # ← new
    ./modules/sops.nix      # ← new
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}