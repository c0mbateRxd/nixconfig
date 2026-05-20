{
  flake.nixosModules.power = {pkgs, lib, ...}: {
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = { governor = "powersave"; turbo = "never"; energy_performance_preference = "power"; };
        charger = { governor = "performance"; turbo = "auto"; energy_performance_preference = "performance"; };
      };
    };
    services.asusd.enable = true;
    powerManagement.powertop.enable = true;
    environment.systemPackages = with pkgs; [asusctl powertop];
  };
}
