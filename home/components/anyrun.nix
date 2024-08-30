{pkgs, ...}:
{
  home.packages = [ pkgs.anyrun ];

  programs.anyrun = {
    enable = true;
    config = {
      x = { fraction = 0.5; };
      y = { absolute = 0; };
      width = { absolute = 800; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = false;
      closeOnClick = false;
      showResultsImmediately = false;
      maxEntries = null;
      extraCss = ''
        #window {
          background-color: rgba(0, 0, 0, 0);
        }

        box#main {
          border-radius: 10px;
          background-color: @theme_bg_color;
        }

        list#main {
          background-color: rgba(0, 0, 0, 0);
          border-radius: 10px;
        }

        list#plugin {
          background-color: rgba(0, 0, 0, 0);
        }

        label#match-desc {
          font-size: 10px;
        }

        label#plugin {
          font-size: 14px;
        }
      '';
    };
  };
}
