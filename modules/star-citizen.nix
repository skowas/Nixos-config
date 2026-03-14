{ ... }:

{
  # Cachix binary cache — avoids rebuilding Star Citizen packages from source
  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
    ];
  };

  programs.rsi-launcher = {
    enable = true;

    # System limits (vm.max_map_count, fs.file-max, PAM hard limits)
    # Required for Star Citizen to run correctly
    setLimits = true;

    # Pre-launch environment — MangoHud + DXVK HUD overlays
    preCommands = ''
      export MANGOHUD=1
      export DXVK_HUD=compiler
    '';
  };
}
