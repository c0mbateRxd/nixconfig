{ flake.nixosModules.ghidra = {pkgs, ...}: { environment.systemPackages = [pkgs.ghidra]; }; }
