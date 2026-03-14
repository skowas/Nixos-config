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
    ./modules/hyprland.nix   # ← Hyprland + Waybar (pick at login alongside COSMIC)
    ./modules/audio.nix
    ./modules/docker.nix
    ./modules/services.nix
    ./modules/gaming.nix
    ./modules/jellyfin.nix
    ./modules/star-citizen.nix 
    ./modules/packages.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
