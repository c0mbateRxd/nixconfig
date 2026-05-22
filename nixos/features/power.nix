{
  flake.nixosModules.power = {pkgs, ...}: {
    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = { governor = "powersave"; turbo = "never"; energy_performance_preference = "power"; };
        charger = { governor = "performance"; turbo = "auto"; energy_performance_preference = "performance"; };
      };
    };
    services.asusd.enable = true;
    # powertop kept for manual analysis only; auto-tune removed because
    # it overrides usbcore.autosuspend=-1 and kills external mice.
    environment.systemPackages = with pkgs; [asusctl powertop];
  };
}
