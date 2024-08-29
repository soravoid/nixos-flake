{ configs, pkgs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
    ./components/hypr/hypridle.nix
    ./components/waybar.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.packages = with pkgs; [
    firefox
    kitty
    mako
    vesktop
    xwaylandvideobridge
    hypridle
    hyprlock
    hyprcursor
    swww
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
