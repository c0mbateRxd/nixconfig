{inputs, ...}: {
  flake.nixosModules.general = {pkgs, ...}: {
    imports = [inputs.nix-index-database.nixosModules.nix-index];
    programs.nix-index-database.comma.enable = true;
    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    nixpkgs.config.allowUnfree = true;
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      glibc zlib openssl libstdc++ ncurses libgcc glib expat bzip2 xz fuse systemd
    ];
    programs.direnv = { enable = true; silent = true; nix-direnv.enable = true; };
    programs.nh = { enable = true; flake = "/home/nyght/nixconfig"; };
    environment.systemPackages = with pkgs; [nil nixd statix alejandra manix nix-inspect nvd];
  };
}
