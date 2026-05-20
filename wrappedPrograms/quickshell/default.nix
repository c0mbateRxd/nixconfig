{inputs, ...}: {
  flake.nixosModules.quickshell = {pkgs, ...}: let
    qs = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    wrapped = pkgs.writeShellScriptBin "quickshell" ''
      exec ${qs}/bin/quickshell -c ${./config} "$@"
    '';
  in {
    environment.systemPackages = [wrapped];
  };
}
