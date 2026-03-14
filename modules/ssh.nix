{ ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      HostKeyAlgorithms = "ssh-ed25519,rsa-sha2-512,rsa-sha2-256";
    };
    hostKeys = [
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  users.users.sko.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5+IKV5TWuC7kn6b9v7tdO5PYPmjJI9HG9F4S5MKn5d skoalmashouq@gmail.com"
  ];
}
