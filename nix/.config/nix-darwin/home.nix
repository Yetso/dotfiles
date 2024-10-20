{ config, pkgs, ... }:

{
  home.username = "yetso";
  home.homeDirectory = "/Users/yetso";
  home.stateVersion = "24.05";

  home.file = {
    ".config/starship.toml".source = ~/dotfiles/starship/starship.toml;
    ".config/bat".source = ~/dotfiles/bat;
    ".config/fastfetch".source = ~/dotfiles/fastfetch;
    ".config/wezterm".source = ~/dotfiles/wezterm/.config;
    ".wezterm-completion.sh".source = ~/dotfiles/wezterm/.wezterm-completion.sh;
    ".terminfo".source = ~/dotfiles/wezterm/.terminfo;
    ".ssh/config".source = ~/dotfiles/ssh/config;
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
