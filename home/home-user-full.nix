{
  imports = [
    ./home-user-base.nix
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulesv2 = [
      "fullscreen,class:^(gamescope)$"
      "monitor DP-2,class:^(gamescope)$"
      "workspace 10,class:^(gamescope)$"
    ];
    workspace = [ "10,border:false,rounding:false" ];
  };
}
