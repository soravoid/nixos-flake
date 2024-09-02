{config, pkgs, ...}:
let
  inherit (config.lib.formats.rasi) mkLiteral;
  theme_bg0 = mkLiteral "@bg0";
  theme_bg1 = mkLiteral "@bg1";
  theme_fg0 = mkLiteral "@fg0";
  theme_accent = mkLiteral "@accent-color";
  theme_urgent = mkLiteral "@urgent-color";
  eight_px = mkLiteral "8px";
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.kitty}/bin/kitty";
    package = pkgs.rofi-wayland;
    theme = {
      "*" = {
        font = "FiraCode Nerd Font Medium 12";
        bg0 = mkLiteral "#2B3339";
        bg1 = mkLiteral "#323D43";
        fg0 = mkLiteral "#D3C6AA";

        accent-color = mkLiteral "#A7C080";
        urgent-color = mkLiteral "#DBBC7F";

        background-color = mkLiteral "transparent";
        text-color = theme_fg0;

        margin = 0;
        padding = 0;
        spacing = 0;
      };

      window = {
        location = mkLiteral "center";
        width = 480;

        background-color = theme_bg0;
      };

      inputbar = {
        spacing = eight_px;
        padding = eight_px;

        background-color = theme_bg1;
      };

      "prompt, entry, element-icon, element-text" = {
        vertical-align = mkLiteral "0.5";
      };

      prompt = {
        text-color = theme_accent;
      };

      textbox = {
        padding = eight_px;
        background-color = theme_bg1;
      };

      listview = {
        padding = mkLiteral "4px 0";
        lines = 8;
        columns = 1;
        fixed-height = mkLiteral "false";
      };

      element = {
        padding = eight_px;
        spacing = eight_px;
      };

      "element normal normal" = {
        text-color = theme_fg0;
      };

      "element normal urgent" = {
        text-color = theme_urgent;
      };

      "element normal active" = {
        text-color = theme_accent;
      };

      "element alternative active" = {
        text-color = theme_accent;
      };

      "element selected" = {
        text-color = theme_bg0;
      };

      "element selected normal, element selected active" = {
        background-color = theme_accent;
      };

      "element selected urgent" = {
        background-color = theme_urgent;
      };

      element-icon = {
        size = mkLiteral "0.8em";
      };

      element-text = {
        text-color = mkLiteral "inherit";
      };
    };
  };
}
