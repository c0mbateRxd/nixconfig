{ flake.nixosModules.cider = {pkgs, ...}: { environment.systemPackages = [pkgs.cider]; }; }
