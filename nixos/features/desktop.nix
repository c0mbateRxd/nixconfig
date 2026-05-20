{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [self.nixosModules.gtk];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter google-fonts
      noto-fonts noto-fonts-emoji liberation_ttf
    ];
    fonts.fontconfig.defaultFonts = {
      serif = ["Cinzel"]; sansSerif = ["Inter"];
      monospace = ["JetBrainsMono Nerd Font Mono"]; emoji = ["Noto Color Emoji"];
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr];
    xdg.portal.config.common.default = "*";

    security.polkit.enable = true;
    services.upower.enable = true;
    services.udisks2.enable = true;
    hardware.enableAllFirmware = true;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    environment.systemPackages = with pkgs; [
      xdg-utils shared-mime-info playerctl brightnessctl
      grim slurp swappy wl-clipboard cliphist
      dunst libnotify wlogout swaybg xwayland-satellite
    ];
  };
}
