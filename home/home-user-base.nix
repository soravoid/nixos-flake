{ configs, pkgs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
    ./components.hypr/hypridle.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.packages = with pkgs; [
    firefox
    kitty
    mako
    vesktop
    xwaylandvideobridge
    xdg-desktop-portal-hyprland
    hypridle
    hyprlock
    hyprcursor
    swww
  ];
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
