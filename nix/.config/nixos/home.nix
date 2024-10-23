{ config, pkgs, ... }:

let
  homeDirectory = "/home/yetso";
  dotfiles = "${homeDirectory}/dotfiles";
in {
  home.username = "yetso";
  home.homeDirectory = pkgs.lib.mkDefault homeDirectory;
  home.stateVersion = "24.05";

  home.file = {
    ".config/bat".source = "${dotfiles}/bat";
    ".config/fastfetch".source = "${dotfiles}/fastfetch";
    ".config/wezterm".source = "${dotfiles}/wezterm/.config";
    ".wezterm-completion.sh".source = "${dotfiles}/wezterm/.wezterm-completion.sh";
    ".terminfo".source = "${dotfiles}/wezterm/.terminfo";
    ".ssh/config".source = "${dotfiles}/ssh/config";
    ".config/nvim".source = "${dotfiles}/nvim";
    ".config/lazygit".source = "${dotfiles}/lazygit";
  };

  programs.fish = {
    enable = true;
    functions = {
      cat = "bat --paging=never --theme='fly16' $argv";
      ls = "eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes $argv";
      lt = "eza --long --tree --level=3 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store|.git' --no-quotes $argv";
      fastfetch = "clear;command fastfetch $argv";
      fish_greeting = "fastfetch";
      # update = "
      #   open /Applications/Latest.app
      #   brew update
      #   brew upgrade
      #   brew upgrade --cask wezterm@nightly --no-quarantine --greedy-latest
      #   cd ~/dotfiles/nix/.config/nix-darwin/
      #   nix flake update --commit-lock-file
      #   darwin-rebuild switch --flake . --impure
      # ";
    };

    shellAbbrs = {
      lg = "lazygit";
      v = "nvim";
      # darwin-rebuild = "darwin-rebuild switch --flake $(readlink -f ~/.config/nix-darwin)";
      nixos-rebuild = "sudo nixos-rebuild switch --flake $(readlink -f ~/dotfiles/nix/.config/nixos) --impure";
    };

  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = false;
    enableIonIntegration = false;
    enableNushellIntegration = false;
    settings = pkgs.lib.importTOML ./starship.toml;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = false;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  home.packages = [

  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;



  programs.git = {
    enable = true;
    userName = "Yetso";
    userEmail = "dav.catoul@gmail.com";
  };

}
