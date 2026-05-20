{self, ...}: {
  flake.nixosModules.royalForkHardware = {
    config, lib, modulesPath, ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];
    boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];
    fileSystems."/" = { device = "/dev/disk/by-uuid/3b170b7e-688d-436e-b6a9-397908056b74"; fsType = "ext4"; };
    fileSystems."/boot" = { device = "/dev/disk/by-uuid/CE95-E950"; fsType = "vfat"; options = ["fmask=0022" "dmask=0022"]; };
    swapDevices = [{device = "/dev/disk/by-uuid/7eaaee8b-b171-4f5b-ad17-4b82af02a9b9";}];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
