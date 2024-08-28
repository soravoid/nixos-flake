let
  wttr_waybar_script = import ../../pkgs/waybar_wttr_script { pkgs };
in
{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    main = {
      margin = "20 20 0 20";
      modules-left = ["hyprland/workspaces", "hyprland/language", "keyboard-state"];
      modules-center = ["clock", "custom/weather"];
      modules-right = ["idle_inhibitor", "pulseaudio", "memory", "temperature", "tray"];

      "hyprland/workspaces" = {
        disable-scroll = true;
        persistent_workspaces = {
          1 = [];
          2 = [];
          3 = [];
          4 = [];
        };
      };

      "hyprland/language" = {
        format = "{} 󰌌 ";
	      min-length = 5;
	      tooltip = false;
      };

      "keyboard-state" = {
        capslock = true;
        format = "{name} {icon} ";
        format-icons = {
            locked = " ";
            unlocked = " ";
        };
      };

      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format = "{:%a, %d %b, %I:%M %p}";
      };

      "custom/weather" = {
        format = "{}";
        tooltip = true;
        interval = 1800;
        exec = "${wttr_waybar_script}/bin/wttr.py";
        return-type = "json";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "󱠏";
          deactivated = "󱠒";
        };
      };

      pulseaudio = {
        reverse-scrolling = 1;
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = "󰋐 {icon} {format_source}";
        format-muted = "󰖁 {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "󰏴";
          headset = "󰋎";
          phone = "";
          portable = "";
          car = "";
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "pavucontrol";
        min-length = 10;
      };

      memory = {
        format = "{used:0.1f}G/{total:0.1f}G  ";
        interval = 30;
      };

      temperature = {
        hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon3/temp1_input";
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = ["", "", "", "", ""];
        tooltip = false;
      };

      tray = {
        icon-size = 16;
        spacing = 0;
      };
    }
  };
};
