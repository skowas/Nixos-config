{ config, pkgs, ... }:

{
  # =====================================================
  # Hyprland — runs alongside COSMIC, pick at login
  # =====================================================

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # NVIDIA-specific env vars required for Hyprland
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME  = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND        = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";   # fixes invisible cursor on NVIDIA
    NIXOS_OZONE_WL     = "1";        # Electron/Chromium apps use Wayland
    MOZ_ENABLE_WAYLAND = "1";        # Firefox Wayland
  };

  # =====================================================
  # Supporting Wayland tooling
  # =====================================================
  environment.systemPackages = with pkgs; [
    waybar   # launched by hyprland.conf via exec-once, not system-wide
    # Launcher
    rofi

    # Notifications
    mako
    libnotify

    # Wallpaper
    swww

    # Screenshots
    grim
    slurp
    swappy

    # Screen lock
    swaylock-effects
    swayidle

    # Clipboard (wl-clipboard already in packages.nix, hyprland-aware)
    cliphist          # already in packages.nix — harmless duplicate

    # Polkit agent (already have polkit_gnome in packages.nix)
    # keeps session auth working under Hyprland
    polkit_gnome

    # Volume / brightness OSD
    swayosd

    # Optional: file picker for GTK apps
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  # =====================================================
  # XDG portal — needed for screen share, file pickers
  # =====================================================
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # =====================================================
  # Security / polkit
  # =====================================================
  security.pam.services.swaylock = {};   # lets swaylock unlock properly
}
