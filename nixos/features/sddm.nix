# SDDM — lightweight themed login. Cursor + power buttons work.
# qylock "sword" theme is a lockscreen theme (43MB video, no SDDM
# power controls, broken cursor) — replaced with a proper SDDM theme.
{pkgs, ...}: {
  flake.nixosModules.sddm = {pkgs, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "where_is_my_sddm_theme";
      extraPackages = [
        (pkgs.where-is-my-sddm-theme.override {
          themeConfig.General = {
            background = "#0a0b0e";
            backgroundFill = "#0a0b0e";
            passwordCharacter = "*";
            passwordFontSize = 32;
            cursorBlinkAnimation = true;
            haveFormBackground = true;
            partialBlur = false;
          };
        })
      ];
      settings = {
        Theme.CursorTheme = "Adwaita";
        General.GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=1,QT_FONT_DPI=96";
      };
    };
    # Cursor theme must be available system-wide for SDDM to find it
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
    ];
  };
}
