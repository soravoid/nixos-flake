{ configs, pkgs, inputs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
    ./components/hypr/hypridle.nix
    ./components/waybar.nix
    ./components/firefox.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.packages = with pkgs; [
    kitty
    mako
    vesktop
    xwaylandvideobridge
    hypridle
    hyprlock
    hyprcursor
    swww
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.config.common.default = "*";
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
