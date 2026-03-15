{ ... }:
{
  environment.etc."nushell/env.nu".text = ''
    # Starship prompt
    ^starship init nu | save -f /tmp/starship_init.nu
    source /tmp/starship_init.nu
  '';

  environment.etc."nushell/config.nu".text = ''
    # ── Hide banner ───────────────────────────────────
    $env.config = { show_banner: false }

    # ── CLI replacements ──────────────────────────────
    alias ls   = eza --icons
    alias ll   = eza --icons -l
    alias la   = eza --icons -la
    alias tree = eza --icons --tree
    alias cat  = bat
    alias grep = rg
    alias find = fd

    # ── Zoxide ────────────────────────────────────────
    def --env z [...args] {
      let result = (^zoxide query --exclude $env.PWD -- ...$args | str trim)
      if $result != "" { cd $result }
    }

    def --env zi [...args] {
      let result = (^zoxide query --interactive -- ...$args | str trim)
      if $result != "" { cd $result }
    }

    $env.config = ($env.config | merge {
      hooks: {
        env_change: {
          PWD: [{ |before, after| ^zoxide add $env.PWD }]
        }
      }
    })

    # ── nixos-update ──────────────────────────────────
    def nixos-update [msg: string = "update"] {
      sudo nixos-rebuild switch --flake /etc/nixos#nixos
      cd /etc/nixos
      git add -A
      git commit -m $msg
      git push
    }
  '';
}
