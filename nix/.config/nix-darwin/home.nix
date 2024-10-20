{ config, pkgs, ... }:

{
  home.username = "yetso";
  home.homeDirectory = "/Users/yetso";
  home.stateVersion = "24.05";


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
