{ configs, pkgs, ... }:
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
    firefox
    kitty
    (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true; }) {})
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
