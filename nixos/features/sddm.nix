# SDDM with qylock "Sword" theme — Dark Souls aesthetic
# The theme is packaged from raw GitHub source (not a flake).
{inputs, ...}: {
  flake.nixosModules.sddm = {pkgs, lib, ...}: let
    # Package the Sword SDDM theme from qylock source
    swordTheme = pkgs.stdenvNoCC.mkDerivation {
      pname = "sddm-theme-sword";
      version = "unstable";
      src = inputs.qylock;
      installPhase = ''
        mkdir -p $out/share/sddm/themes/Sword
	cp -aR themes/sword/. $out/share/sddm/themes/Sword/
      '';
    };
  in {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "Sword";
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        swordTheme
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qt5compat
      ];
    };
    environment.systemPackages = [swordTheme];
  };
}
