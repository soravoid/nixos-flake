{ pkgs, inputs, ... }:
{
  imports = [
    ./components/hypr/hyprland.nix
    ./components/sops.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    vesktop
    nerdfonts
  ];

  services.openssh.enable = true;
  services.openssh.ports = [ 22 ];
  services.openssh.settings = {
    PasswordAuthentication = true;
    AllowUsers = [ "user" ];
    UseDns = true;
    X11Forwarding = false;
    PermitRootLogin = "no";
  };

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
