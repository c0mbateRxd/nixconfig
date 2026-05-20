# royalFork — NixOS
## ASUS TUF A15 | Niri + Quickshell | Ashen Keep (Dark Souls)
### user: nyght | host: royalFork

---

### First boot
```bash
passwd nyght          # change from "changeme"
# set git identity in wrappedPrograms/git.nix then:
nh os switch
```

### Daily usage
```bash
nh os switch          # rebuild + switch
nh os switch --dry    # preview diff (nvd)
nix flake update      # update all inputs

# Push to GitHub (manual, when you're happy):
cd ~/nixconfig && git add -A && git commit -m "msg" && git push
```

### CTF shell
```bash
cd ~/ctf && nix develop .#ctf
# OR add `use flake` to ~/ctf/.envrc for auto-activation via direnv
```

### Run anything without installing
```bash
, nmap -h      # comma runs from nixpkgs, no install
, gdb ./bin
```

### Add a new app
1. `nixos/features/myapp.nix` → `flake.nixosModules.myapp = ...`
2. Add `self.nixosModules.myapp` to `nixos/hosts/royalFork/configuration.nix`
3. `nh os switch`

### Ashen Keep palette
| Name | Hex | Role |
|---|---|---|
| Abyss | `#0a0b0e` | bg |
| Bonfire Gold | `#c49a30` | hero accent, focus ring |
| Blood Ember | `#a83a3a` | errors, power button |
| Moss on Ruins | `#5a8a58` | success |
| Frigid Steel | `#4a7e96` | info, Wi-Fi |
| Lothric Blue | `#6070a8` | links, Bluetooth |
