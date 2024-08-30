{ pkgs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    vesktop
    nerdfonts
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
    };
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.thefuck.enable = true;
  programs.thefuck.enableZshIntegration = true;
  
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
