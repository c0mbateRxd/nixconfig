# SDDM — wayland, working cursor, power buttons functional.
{...}: {
  flake.nixosModules.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "where_is_my_sddm_theme";
      extraPackages = [pkgs.where-is-my-sddm-theme];
      settings = {
        Theme.CursorTheme = "Adwaita";
      };
    };
    environment.systemPackages = with pkgs; [
      where-is-my-sddm-theme
      adwaita-icon-theme
    ];
  };
}
