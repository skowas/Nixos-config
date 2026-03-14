{
  services.xserver.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = "sko";
  };

  programs.xwayland.enable = true;
}
