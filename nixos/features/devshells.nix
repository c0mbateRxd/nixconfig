{
  perSystem = {pkgs, ...}: {
    devShells.ctf = pkgs.mkShell {
      name = "ctf-shell";
      packages = with pkgs; [
        gdb pwndbg pwntools
        radare2 ltrace strace
        sqlmap ffuf gobuster
        python3 python3Packages.pwntools python3Packages.pycryptodome
        python3Packages.requests python3Packages.z3
        netcat-gnu socat nmap
      ];
      shellHook = ''
        echo ""
        echo "  ⚔  CTF shell — royalFork"
        echo "  󰆧  pwntools · gdb+pwndbg · radare2 · sqlmap · ffuf"
        echo ""
      '';
    };
  };
}
