{ pkgs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.packages = with pkgs; [
    kitty
    vesktop
  ];
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
