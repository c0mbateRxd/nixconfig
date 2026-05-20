{
  flake.nixosModules.git = {pkgs, ...}: {
    programs.git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        core.editor = "nvim";
        pull.rebase = false;
        push.autoSetupRemote = true;
        alias = { st = "status"; lg = "log --oneline --graph --decorate --all"; undo = "reset HEAD~1 --mixed"; };
        diff.colorMoved = "default";
        # Set before first push:
        # user.name  = "your-name";
        # user.email = "your-email";
      };
    };
    environment.systemPackages = [pkgs.lazygit];
  };
}
