{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # =========================
    # Development & CLI
    # =========================
    git
    vencord
    wget
    neovim
    ripgrep
    fd
    bat
    eza
    zoxide
    xh
    hyperfine
    delta
    ripgrep-all
    just
    dust
    dua
    rustc
    rustup
    
    # Shells
    fish
    nushell
    starship
    gcc

    # Terminal
    zellij
    gitui
    yazi
    kitty
    kitty-img
    kitty-themes
    wiremix    

    # =========================
    # Gaming & Tools
    # =========================
    mangohud
    protonup-ng
    lutris

    # =========================
    # Docker & System
    # =========================
    docker
    docker-client
    tailscale
    polkit_gnome
    ntfs3g
    exfat

    # =========================
    # Media & Apps
    # =========================
    element-desktop
    obsidian
    mpc
    mpd
    rmpc
    jellyfin-media-player

    # =========================
    # Utilities
    # =========================
    wl-clipboard
    cliphist
    p7zip
    neofetch
    bazaar
    # =========================
    # Optional / Advanced
    # (Keep only if needed)
    # =========================
    espanso-wayland
    jetbrains-toolbox
    presenterm
    kondo
    mprocs
    mask
    cargo-info
    bacon
    evil-helix
  ];
}
