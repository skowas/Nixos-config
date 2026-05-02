{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "sko";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.plasma-nm
    # KDE Utilities
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kolourpaint
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdiff3
    kdePackages.cantor
    labplot
    kdePackages.kalgebra
    kdePackages.step
    kdePackages.calligra
    kdePackages.kdeconnect-kde
    kdePackages.konversation

    # Hardware/System Utilities
    kdePackages.isoimagewriter
    kdePackages.partitionmanager
    hardinfo2
    wayland-utils
    wl-clipboard
    vlc
  ];
}
