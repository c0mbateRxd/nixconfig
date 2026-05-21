{inputs, self, ...}: {
  flake.nixosConfigurations.royalFork = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.royalForkHost];
  };
  flake.nixosModules.royalForkHost = {pkgs, config, lib, ...}: {
    imports = [
      self.nixosModules.royalForkHardware
      self.nixosModules.base
      self.nixosModules.desktop
      self.nixosModules.general
      self.nixosModules.audio
      self.nixosModules.power
      self.nixosModules.networking
      self.nixosModules.gtk
      self.nixosModules.sddm
      self.nixosModules.brave
      self.nixosModules.vesktop
      self.nixosModules.cider
      self.nixosModules.documents
      self.nixosModules.wireshark
      self.nixosModules.ghidra
      self.nixosModules.cybersec
      self.nixosModules.bash
      self.nixosModules.git
      self.nixosModules.niri
      self.nixosModules.kitty
      self.nixosModules.noctalia
      self.nixosModules.rofi
      inputs.hjem.nixosModules.default
    ];

    preferences.user.name = "nyght";
    networking.hostName = "royalFork";

    users.users.nyght = {
      isNormalUser = true;
      description = "nyght";
      extraGroups = ["wheel" "networkmanager" "video" "audio" "input" "wireshark"];
      shell = pkgs.bash;
      initialPassword = "Yc@tAbmP.129";
    };

    hjem = {
      users.nyght = { enable = true; directory = "/home/nyght"; user = "nyght"; };
      clobberByDefault = true;
    };

    # GRUB + EFI + Windows dual-boot
    boot.loader.grub = { enable = true; efiSupport = true; device = "nodev"; useOSProber = true; };
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages;
    boot.kernelParams = [
      "quiet" "splash"
      "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"
      "NVreg_DynamicPowerManagement=0x02"
      "amd_pstate=guided"
      "usbcore.autosuspend=-1"
    ];

    boot.plymouth.enable = true;
    boot.supportedFilesystems = ["ntfs"];
    boot.tmp.cleanOnBoot = true;

    # Boot speed
    boot.loader.timeout = 3;
    systemd.services.NetworkManager-wait-online.enable = false;
    boot.initrd.systemd.enable = true;

    # Nvidia — RTX 3050 drives display, no PRIME
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    programs.appimage.enable = true;
    programs.appimage.binfmt = true;

    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
   	 LC_ADDRESS = "en_US.UTF-8";
   	 LC_IDENTIFICATION = "en_US.UTF-8";
   	 LC_MEASUREMENT = "en_US.UTF-8";
   	 LC_MONETARY = "en_US.UTF-8";
   	 LC_NAME = "en_US.UTF-8";
   	 LC_NUMERIC = "en_US.UTF-8";
   	 LC_PAPER = "en_US.UTF-8";
   	 LC_TELEPHONE = "en_US.UTF-8";
   	 LC_TIME = "en_US.UTF-8";
    };
    system.stateVersion = "25.11";
  };
}
