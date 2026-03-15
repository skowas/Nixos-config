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
    lazydocker
    kitty
    wiki-tui
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
    wiki-tui
    sops
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



  (pkgs.buildGoModule rec {
    pname = "surge";
    version = "0.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "surge-downloader";
      repo = "surge";
      rev = "v${version}";
      hash = "sha256-0rgD9tMt3P/Bme39WleIdQQFOzU1RlG8H43bVNjkC50=";
    };
    vendorHash = "sha256-XIXH/d4Fjk3KFFQn+MfRGiAgR48KGvWoh1PuNb3yryg=";
  doCheck = false;
  })


  ];
}
