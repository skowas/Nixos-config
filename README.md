# ❄️ Sko's NixOS Config

A modular NixOS configuration for a gaming/development workstation running COSMIC + Hyprland on NVIDIA.

## 📦 Flake Inputs

| Input | Purpose |
|---|---|
| `nixpkgs` | NixOS unstable channel |
| `spicetify-nix` | Spotify client customization |
| `nix-gaming` | Wine/Proton patches for gaming |
| `nix-citizen` | Star Citizen launcher & system tweaks |
| `sops-nix` | Encrypted secrets management |

## 🗂️ Structure

```
.
├── flake.nix                  # Inputs, outputs, host definition
├── flake.lock                 # Pinned input versions
├── configuration.nix          # Top-level imports
├── hardware-configuration.nix # Auto-generated hardware config
├── .sops.yaml                 # sops age key config
├── secrets/
│   └── secrets.yaml           # Encrypted secrets (safe to commit)
└── modules/
    ├── audio.nix              # PipeWire audio
    ├── bluetooth.nix          # Bluetooth support
    ├── boot.nix               # Bootloader config
    ├── desktop.nix            # COSMIC desktop + display manager
    ├── docker.nix             # Docker daemon
    ├── filesystems.nix        # Mount points & filesystems
    ├── gaming.nix             # Steam + GameMode + Gamescope
    ├── hardware.nix           # OpenTabletDriver, uinput
    ├── hyprland.nix           # Hyprland WM + NVIDIA env vars
    ├── jellyfin.nix           # Jellyfin media server
    ├── locale.nix             # Timezone & locale
    ├── networking.nix         # NetworkManager + hostname
    ├── nushell.nix            # Nushell as default shell + aliases
    ├── nvidia.nix             # NVIDIA drivers
    ├── packages.nix           # System packages
    ├── services.nix           # Misc system services
    ├── ssh.nix                # OpenSSH server (key-only auth)
    ├── sops.nix               # sops-nix secret decryption
    ├── star-citizen.nix       # RSI Launcher + system limits
    └── users.nix              # User accounts & groups
```

## 🖥️ Desktop

- **Primary:** COSMIC (auto-login)
- **Secondary:** Hyprland (selectable at login screen)
- **Display Manager:** cosmic-greeter
- **GPU:** NVIDIA (modesetting + Wayland env vars configured)

## 🐚 Shell (Nushell)

Default shell with the following configured in `/etc/nushell/config.nu`:

| Alias | Runs |
|---|---|
| `ls` | `eza --icons` |
| `ll` | `eza --icons -l` |
| `la` | `eza --icons -la` |
| `tree` | `eza --icons --tree` |
| `cat` | `bat` |
| `grep` | `rg` |
| `find` | `fd` |
| `z <dir>` | zoxide jump |
| `zi` | zoxide interactive jump |

### Custom Commands

```nushell
# Rebuild, commit and push config in one command
nixos-update "commit message"
```

## 🔐 Secrets (sops-nix)

Secrets are encrypted with [sops](https://github.com/getsops/sops) using an age key derived from the host SSH key.

```bash
# Edit secrets
cd /etc/nixos
nix shell nixpkgs#sops -c sops secrets/secrets.yaml

# Derive age public key from host SSH key
nix shell nixpkgs#ssh-to-age -c ssh-to-age -i /etc/ssh/ssh_host_ed25519_key.pub
```

The private age key lives at `~/.config/sops/age/keys.txt` and is **never committed**.

## 🔑 SSH

- Password authentication **disabled**
- Root login **disabled**
- Accepted key types: `ed25519`, `rsa-sha2-512`, `rsa-sha2-256`

```bash
ssh sko@192.168.100.145
```

## 🎮 Gaming

- **Steam** with Gamescope session
- **GameMode** for CPU/GPU performance boost
- **Lutris** for non-Steam games
- **MangoHud** overlay (FPS, temps, frametimes)
- **ProtonUp-NG** for managing Proton-GE
- **Star Citizen** via RSI Launcher (`nix-citizen`)
  - `vm.max_map_count` and `fs.file-max` tuned automatically
  - DXVK HUD + MangoHud enabled by default

## 🗑️ Garbage Collection

Automatic weekly GC, removes generations older than 30 days:

```bash
# Manual run
sudo nix-collect-garbage -d
```

## 🚀 Applying Changes

```nushell
nixos-update "describe your change"
```

Or manually:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

## 🔄 Bootstrapping on a New Machine

```bash
# Clone the config
git clone https://github.com/skowas/Nixos-config /etc/nixos

# Update hardware config for the new machine
nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix

# Restore the sops age key
mkdir -p ~/.config/sops/age
# copy your keys.txt here

# Rebuild
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```
