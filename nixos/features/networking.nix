{
  flake.nixosModules.networking = {pkgs, ...}: {
    networking.networkmanager.enable = true;
    networking.firewall.enable = true;
    hardware.wirelessRegulatoryDatabase = true;
    environment.systemPackages = with pkgs; [networkmanagerapplet];
  };
}
