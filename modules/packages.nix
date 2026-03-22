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
    ffmpeg   
    rmpc
    jellyfin-media-player
    spotdl
    ncspot 
    librespot  
    youtube-tui

    
    # =========================
    # Utilities
    # =========================
    wl-clipboard
    cliphist
    p7zip
    neofetch
    fastfetch
    sops
    bazaar
    bluetui
    tdf
    inetutils
    zssh   
    fast-ssh 
    ircdog

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
     
    (let
  twintail-deb = pkgs.fetchurl {
    url = "https://github.com/TwintailTeam/TwintailLauncher/releases/download/ttl-v1.1.15/twintaillauncher_1.1.15_amd64.deb";
    sha256 = "64983405b296728718f31504ac4d1a0e003b4ce93ca6705f4092c71421fceab0";
  };
in pkgs.stdenv.mkDerivation {
  pname = "twintaillauncher";
  version = "1.1.15";
  src = twintail-deb;
  nativeBuildInputs = [ pkgs.dpkg pkgs.autoPatchelfHook pkgs.makeWrapper ];
  buildInputs = with pkgs; [
    webkitgtk_4_1 gtk3 glib openssl libayatana-appindicator
    dbus librsvg gdk-pixbuf pango cairo atk
    xorg.libX11 xorg.libXext xorg.libxcb libsoup_3 curl
  ];
  unpackPhase = "dpkg-deb -x $src .";
  installPhase = ''
    mkdir -p $out
    cp -r usr/bin $out/bin
    cp -r usr/share $out/share
  '';
  postFixup = ''
    wrapProgram $out/bin/twintaillauncher \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath (with pkgs; [
        libayatana-appindicator
      ])}
  '';
})











  ];
}
