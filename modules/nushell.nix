{ ... }:
{
  environment.etc."nushell/config.nu".text = ''
    def nixos-update [
      msg: string = "update"
    ] {
      sudo nixos-rebuild switch --flake /etc/nixos#nixos
      cd /etc/nixos
      git add -A
      git commit -m $msg
      git push
    }
  '';
}
