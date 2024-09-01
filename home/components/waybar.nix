{ pkgs, ... }:
let
  wttr_waybar_script = pkgs.stdenv.mkDerivation {
    name = "waybar_wttr_script";
    buildInputs = [ (pkgs.python3.withPackages (p: [ p.requests ])) ];
    unpackPhase = ":";
    installPhase = "install -m755 -D ${./wttr.py} $out/bin/wttr";
  };
in
{
  home.packages = [ pkgs.noto-fonts-color-emoji ];

  programs.waybar.enable = true;
  programs.waybar.settings = {
    main = {
      margin = "20 20 0 20";
      modules-left = [ "hyprland/workspaces" "hyprland/language" "keyboard-state" ];
      modules-center = [ "clock" "custom/weather" ];
      modules-right = [ "idle_inhibitor" "pulseaudio" "memory" "temperature" "tray" ];

      "hyprland/workspaces" = {
        disable-scroll = true;
        persistent_workspaces = {
          "1" = [];
          "2" = [];
          "3" = [];
          "4" = [];
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
        exec = "${wttr_waybar_script}/bin/wttr";
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
        hwmon-path = pkgs.lib.mkDefault "/sys/devices/platform/coretemp.0/hwmon/hwmon3/temp1_input";
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" "" "" ];
        tooltip = false;
      };

      tray = {
        icon-size = 16;
        spacing = 0;
      };
    };
  };
  programs.waybar.style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: MesloLGM Nerd Fonts;
        min-height: 20px;
    }

    window#waybar {
        background: transparent;
    }

    window#waybar.hidden {
        opacity: 0.2;
    }

    #workspaces {
        margin-right: 8px;
        border-radius: 10px;
        transition: none;
        background: #383c4a;
    }

    #workspaces button {
        transition: none;
        color: #7c818c;
        background: transparent;
        padding: 5px;
        font-size: 18px;
    }

    #workspaces button.persistent {
        color: #7c818c;
        font-size: 12px;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button:hover {
        transition: none;
        box-shadow: inherit;
        text-shadow: inherit;
        border-radius: inherit;
        color: #383c4a;
        background: #7c818c;
    }

    #workspaces button.focused {
        color: white;
    }

    #language {
        padding-left: 16px;
        padding-right: 8px;
        border-radius: 10px 0px 0px 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #keyboard-state {
        margin-right: 8px;
        padding-right: 16px;
        border-radius: 0px 10px 10px 0px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #clock {
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px 0px 0px 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #custom-weather {
        padding-right: 16px;
        border-radius: 0px 10px 10px 0px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #idle_inhibitor {
        margin-right: 8px;
    }

    #idle_inhibitor.deactivated {
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px 10px 10px 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #idle_inhibitor.activated {
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px 10px 10px 10px;
        transition: none;
        color: #ffffff;
        background: #eb4d4b;
    }

    #pulseaudio {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #pulseaudio.muted {
        background-color: #90b1b1;
        color: #2a5c45;
    }

    #memory {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #temperature {
        margin-right: 8px;
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    #temperature.critical {
        background-color: #eb4d4b;
    }

    #tray {
        padding-left: 16px;
        padding-right: 16px;
        border-radius: 10px;
        transition: none;
        color: #ffffff;
        background: #383c4a;
    }

    @keyframes blink {
        to {
            background-color: #ffffff;
            color: #000000;
        }
    }
  '';
}
