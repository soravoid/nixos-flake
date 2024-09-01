{
  inputs,
  pkgs,
  ...
}:
let
  start_swww_script = pkgs.writeShellScript "start_swww.sh" ''
    swww-daemon
    sleep 0.5
    swww img ${../wallpapers/rags.jpg} -o DP-2
    swww img ${../wallpapers/sl.jpg} -o HDMI-A-1
  '';
in
{
  home.packages = with inputs; [
    swww.packages.${pkgs.system}.swww
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${start_swww_script}"
  ];
}

