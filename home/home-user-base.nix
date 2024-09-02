{ pkgs, inputs, ... }:
{
  imports = [
    ./components/firefox.nix
    ./components/hyprland
    ./components/sops.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    kitty
    vesktop
    nerdfonts
    kdePackages.ark
    kdePackages.okular
    pavucontrol
  ];

  programs.ncspot.enable = true;

  programs.ssh.enable = true;
  programs.ssh.addKeysToAgent = "yes";
  programs.ssh.matchBlocks = {
    "github.com" = {
      hostname = "github.com";
      identitiesOnly = true;
      identityFile = "/home/user/.ssh/id_github_rw";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "43506164+soravoid@users.noreply.github.com";
    userName = "Jaden";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "/home/user/.ssh/id_github_sign";
    };
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
