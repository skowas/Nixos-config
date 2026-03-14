{ pkgs, ... }:

{
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

    services.udev.extraRules = ''
  ATTR{idVendor}=="13d3", ATTR{idProduct}=="3602", ENV{ID_MTP_DEVICE}="0", ENV{ID_MEDIA_PLAYER}="0", ATTR{authorized}="1"
'';
  
  systemd.services.bluetooth-unblock = {
    wantedBy = [ "bluetooth.target" ];
    before = [ "bluetooth.service" ];
    serviceConfig = {
      Type = "oneshot";
      
      ExecStart = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
    };
  };
}
