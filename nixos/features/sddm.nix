# SDDM — minimal dark theme, working cursor + power buttons.
# Uses where-is-my-sddm-theme (Qt6 compatible with kdePackages.sddm).
{...}: {
  flake.nixosModules.sddm = {pkgs, ...}: let
    sddmTheme = pkgs.where-is-my-sddm-theme.override {
      themeConfig.General = {
        background = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
        backgroundMode = "fill";
        blur = "false";
        passwordCharacter = "*";
        passwordFontSize = "24";
        cursorBlinkAnimation = "true";
        haveFormBackground = "true";
      };
    };
  in {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "where_is_my_sddm_theme";
      extraPackages = [sddmTheme];
      settings.Theme.CursorTheme = "Adwaita";
    };
    environment.systemPackages = [sddmTheme pkgs.adwaita-icon-theme];
  };
}
