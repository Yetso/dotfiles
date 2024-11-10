{ config, pkgs, ... }:

let
  homeDirectory = "${builtins.getEnv "HOME"}";
  dotfiles = "${homeDirectory}/dotfiles";
in {
  xdg.enable = true;
  home = {
    username = "yetso";
    homeDirectory = "${homeDirectory}";
    stateVersion = "24.11";
    file = {
      # ".config/fastfetch".source = "${dotfiles}/fastfetch";
      ".config/wezterm".source = "${dotfiles}/wezterm/.config";
      ".wezterm-completion.sh".source = "${dotfiles}/wezterm/.wezterm-completion.sh";
      ".terminfo".source = "${dotfiles}/wezterm/.terminfo";
      ".ssh/config".source = "${dotfiles}/ssh/config";
      ".config/nvim".source = "${dotfiles}/nvim";
      # ".config/lazygit".source = "${dotfiles}/lazygit";
    };
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_ENV_HINTS = "true";
      XDG_CONFIG_HOME = "/Users/yetso/.config";
      _ZO_RESOLVE_SYMLINKS = "1";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    # autosuggestion.stategy = [        # not available yet
    #   "completion"
    # ];
    # syntaxHighlighting.enable = true;     #activated with flake.nix on a system level
    enableCompletion = false;   # disabled because already there for system shell
    loginExtra = "fastfetch";
    shellAliases = {
      # cat = "bat --paging=never --theme='fly16'";
      cat = "bat";
      lt = "ls --long --tree --level=3 --ignore-glob='.git'";
      # ls = "eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes";
      # lt = "eza --long --tree --level=3 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store|.git' --no-quotes";
      fastfetch = "clear;command fastfetch";
      lg = "lazygit";
      v = "nvim";
      docker = "podman";
      update = "
        open /Applications/Latest.app
        brew update --quiet
        brew upgrade --quiet
        brew upgrade --quiet --cask wezterm@nightly --no-quarantine --greedy-latest
        echo -e '\\e[34m==>\\e[0m \\e[1mupdating flake lock...\\e[0m'
        (cd ~/dotfiles/nix/.config/nix-darwin &&
        nix flake update --commit-lock-file > /dev/null)
        echo -e '\\e[34m==>\\e[0m \\e[1m rebuilding nix-darwin...\\e[0m'
        darwin-rebuild switch --flake ~/dotfiles/nix/.config/nix-darwin --impure > /dev/null
      ";
    };
  };

  programs.fish = {
    enable = false;
    shellAbbrs = {
      lg = "lazygit";
      v = "nvim";
      darwin-rebuild = "darwin-rebuild switch --flake $(readlink -f ~/.config/nix-darwin)";
    };
    functions = {
      # cat = "bat --paging=never --theme='fly16' $argv";
      cat = "bat $argv";
      ls = "eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes $argv";
      lt = "eza --long --tree --level=3 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store|.git' --no-quotes $argv";
      fastfetch = "clear;command fastfetch $argv";
      fish_greeting = "fastfetch";
      update = "
        set -l original_dir (pwd)
        open /Applications/Latest.app
        brew update
        brew upgrade
        brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest
        cd ~/dotfiles/nix/.config/nix-darwin/
        nix flake update --commit-lock-file
        darwin-rebuild switch --flake . --impure
        cd $original_dir
      ";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = true;
    enableIonIntegration = false;
    enableNushellIntegration = false;
    settings = pkgs.lib.importTOML ./starship.toml;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = true;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  programs.lazygit = {
    enable = true;
    settings.gui = {
      theme.selectedLineBgColor = [ "#1c1c1c" ];
      nerdFontsVersion = 3;
    };
  };

  programs.fastfetch = {
    enable = true;
    settings = pkgs.lib.importJSON ./fastfetchConfig.jsonc;
  };

  programs.eza = {
    enable = true;
    icons = "always";
    extraOptions = [
      "--binary"
      "--group-directories-first"
      "--header"
      "--no-quotes"
      "--all"
      "--color=always"
      "--ignore-glob=.DS_Store"
      # lt = "eza --long --tree --level=3 --ignore-glob='.DS_Store|.git'";
    ];
  };

  programs.bat = {
    enable = true;
    config.theme = "fly16";
    themes = {
      fly16 = {
        src = pkgs.fetchFromGitHub {
          owner = "bluz71";
          repo = "fly16-bat"; # Bat uses sublime syntax for its themes
          rev = "d13c2c2a03e84819b2df2c50bc824b74604b9844";
          hash = "sha256-QtZurXK6wNnyWiiQWfyAMFsV5ZWyi84jJNkTgZYoMCE=";
        };
        file = "fly16.tmTheme";
      };
    };
  };

  # home.packages = [
  
  # ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.git = {
    enable = true;
    userName = "Yetso";
    userEmail = "dav.catoul@gmail.com";
  };
}
