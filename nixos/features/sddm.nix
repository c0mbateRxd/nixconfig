# SDDM — SilentSDDM "rei" theme via its official NixOS flake module.
# Rei: dark, blue-tinted, minimal. No extra color overrides needed —
# rei already matches the dark cold aesthetic of Ashen Keep.
{inputs, ...}: {
  flake.nixosModules.sddm = {pkgs, ...}: {
    imports = [inputs.silentSDDM.nixosModules.default];

    programs.silentSDDM = {
      enable = true;
      theme  = "rei";
    };

    services.displayManager.sddm = {
      package        = pkgs.kdePackages.sddm;
      wayland.enable = true;
    };
  };
}
