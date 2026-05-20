# Quickshell panel wrapper — points to ./config QML source
{inputs, self, ...}: {
  perSystem = {pkgs, lib, ...}: {
    packages.quickshellWrapped =
      pkgs.writeShellScriptBin "quickshell" ''
        exec ${lib.getExe inputs.quickshell.packages.${pkgs.system}.default} \
          -c ${./config} "$@"
      '';
  };
}
