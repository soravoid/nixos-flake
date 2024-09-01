{
  pkgs,
  osConfig,
  ...
}:
let
  inherit (osConfig.networking) hostName;
in
{
  imports = [
    ./hypridle.nix
    ../rofi.nix
    ../waybar.nix
    ./hyprlock-${hostName}.nix
    ./swww-${hostName}.nix
  ];

  home.packages = with pkgs; [
    hyprcursor
    nordzy-cursor-theme
    mako
    xwaylandvideobridge
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.config.common.default = "*";

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = pkgs.lib.mkDefault [ ",preferred,auto,1" ];

    "$terminal" = "kitty -1";
    "$fileManager" = "dolphin";
    "$menu" = "rofi -show drun";

    exec-once = [
      "mako"
      "/usr/lib/polkit-kde-authentication-agent-1"
      "waybar"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment"
    ];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "EDITOR,nvim"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    general = {
      gaps_in = 4;
      gaps_out = 20;
      border_size = 2;

      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";

      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      drop_shadow = true;
      shadow_range = 4; "col.shadow" = "rgba(1a1a1aee)";

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
        vibrancy = 0.1696;
      };
    };

    animations = {
      enabled = true;
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 7, myBezier"
        "windowsOut, 1, 7, default, popin, 80%"
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 7, default"
        "workspaces, 1, 6, default"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = false;
    };

    input = {
      kb_layout = "us";
      kb_model = "";
      kb_options = "";
      kb_rules = "";

      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = true;
      };
    };

    gestures = {
      workspace_swipe = false;
    };

    "$mod" = "SUPER";

    bind = [
      "$mod, Q, exec, $terminal"
      "$mod, C, killactive"
      "$mod, E, exec, $fileManager"
      "$mod, F, toggleFloating"
      "$mod, R, exec, $menu"
      "$mod, D, exec, vesktop"
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
    ]
    ++ (
      builtins.concatLists (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString(x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
        ]
      )
      10)
    );

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    windowrulev2 = [
      "suppressevent maximize,class:.*"
      "opacity 0.0 override,class:^(xwaylandvideobridge)$"
      "noanim,class:^(xwaylandvideobridge)$"
      "noinitialfocus,class:^(xwaylandvideobridge)$"
      "maxsize 1 1,class:^(xwaylandvideobridge)$"
      "noblur,class:^(xwaylandvideobridge)$"
    ];
  };
}
