{ ... }:
{
  nix.settings = {
    substituters = [ "https://nix-citizen.cachix.org" ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
    ];
  };
  programs.rsi-launcher = {
    enable = true;
    setLimits = true;
    preCommands = ''
      export MANGOHUD=1
      export DXVK_HUD=compiler
    '';
  };
}
