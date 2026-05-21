# SDDM — SilentSDDM "rei" theme via its official NixOS flake module.
# Rei: dark, blue-tinted. Colors tuned to Ashen Keep palette.
{inputs, ...}: {
  flake.nixosModules.sddm = {pkgs, ...}: {
    imports = [inputs.silentSDDM.nixosModules.default];

    programs.silentSDDM = {
      enable = true;
      theme  = "rei";
      settings = {
        # Background — Abyss dark
        Background             = "#0a0b0e";
        BackgroundMode         = "fill";
        # Accent — Lothric Blue (matches our theme)
        AccentColor            = "#6070a8";
        # Text
        MainColor              = "#b0b8c8";
        # Input field
        InputColor             = "#12141a";
        InputBorderColor       = "#2c3040";
        InputBorderRadius      = "8";
        # Cursor
        HideCursor             = "false";
      };
    };

    # kdePackages.sddm is set by silentSDDM module automatically
    # but we enforce Qt6 SDDM explicitly
    services.displayManager.sddm = {
      package  = pkgs.kdePackages.sddm;
      wayland.enable = true;
    };
  };
}
