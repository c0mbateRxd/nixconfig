{self, ...}: {
  flake.nixosModules.bash = {pkgs, lib, config, ...}: let
    user = config.preferences.user.name;
    starshipToml = pkgs.writeText "starship.toml" ''
      add_newline = false
      palette = "ashen"

      [palettes.ashen]
      gold   = "#c49a30"
      moss   = "#5a8a58"
      ember  = "#a83a3a"
      frost  = "#4a7e96"
      ink    = "#6a7088"
      ash    = "#b0b8c8"
      violet = "#6070a8"

      [character]
      success_symbol = "[❯](bold gold)"
      error_symbol   = "[❯](bold ember)"

      [directory]
      style             = "bold frost"
      truncation_length = 3
      truncate_to_repo  = true

      [git_branch]
      style  = "bold violet"
      symbol = " "

      [git_status]
      style = "bold gold"

      [cmd_duration]
      style    = "bold moss"
      min_time = 2000
      format   = "took [$duration]($style) "

      [username]
      style_user  = "bold ember"
      show_always = false
    '';
  in {
    programs.bash = {
      enable = true;
      completion.enable = true;
      interactiveShellInit = ''
        bind "set show-all-if-ambiguous on"
        bind 'TAB: menu-complete'
        bind '"\e[Z": menu-complete-backward'
        bind "set completion-ignore-case on"
        bind "set colored-stats on"
        bind "set mark-symlinked-directories on"

        HISTSIZE=10000
        HISTFILESIZE=20000
        HISTCONTROL=ignoreboth:erasedups
        shopt -s histappend checkwinsize

        eval "$(${lib.getExe pkgs.starship} init bash)"
        eval "$(${lib.getExe pkgs.zoxide} init bash)"
        source ${pkgs.fzf}/share/fzf/key-bindings.bash
        source ${pkgs.fzf}/share/fzf/completion.bash
      '';
      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ~/nixconfig#royalFork";
        check   = "nix flake check ~/nixconfig";
        clean   = "sudo nix-collect-garbage -d";
        update  = "nix flake update ~/nixconfig";
        gs = "git status"; ga = "git add"; gc = "git commit"; gp = "git push";
        gl = "git log --oneline --graph --decorate --all";
        ls   = "${lib.getExe pkgs.eza} --icons --group-directories-first";
        ll   = "${lib.getExe pkgs.eza} --icons --group-directories-first -la";
        lt   = "${lib.getExe pkgs.eza} --icons --tree --level=2";
        cat  = "${lib.getExe pkgs.bat} --style=plain";
        top  = "${lib.getExe pkgs.btop}";
        b64d = "base64 --decode";
        b64e = "base64";
      };
    };
    # Deploy starship.toml to a path starship can actually read
    hjem.users.${user}.files.".config/starship.toml".source = starshipToml;

    environment.sessionVariables = {
      EDITOR = "nvim"; VISUAL = "nvim";
    };
    environment.systemPackages = with pkgs; [
      starship zoxide fzf bat eza ripgrep fd btop dust tldr
      lazygit fastfetch yt-dlp ffmpeg imagemagick
      tree file wget killall tmux
    ];
  };
}
