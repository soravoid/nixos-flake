{
  description = "Set up NixOS for personal use.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  inputs.anyrun.url = "github:anyrun-org/anyrun";
  inputs.anyrun.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, disko, home-manager, ...}@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations.thinkpadx1 = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./disk-configs/disk-config-thinkpadx1.nix
        ./configuration.nix
        ./hosts/thinkpadx1.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
    homeConfigurations.thinkpadx1 = home-manager.lib.homeManagerConfiguration {
      modules = [
        anyrun.homeManagerModules.default
        ./home/home-user-devel.nix
        {
          wayland.windowManager.hyprland.settings.monitor =
            lib.mkBefore ([ "eDP-1,1920x1080@60,0x0,1" ]);
          programs.waybar.settings.main.temperature.hwmon-path =
            lib.mkBefore "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp4_input";
        }
      ];
    }
    nixosConfigurations.asrock = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        disko.nixosModules.disko
        ./disk-configs/disk-config-asrock.nix
        ./configuration.nix
        ./hosts/thinkpadx1.nix
      ];
    };
    homeConfigurations.asrock = home-manager.lib.homeManagerConfiguration {
      modules = [
        anyrun.homeManagerModules.default
        ./home-user-full.nix
        {
          wayland.windowManager.hyprland.settings.monitor =
            lib.mkBefore ([
              # Don't ask about the positioning
              "DP-2,2560x1440@144,-1920x150,1"
              "HDMI-A-1,1920x1080@60,0x0,1.33333"
            ]);
          programs.waybar.settings.main.temperature.hwmon-path =
            lib.mkBefore "/sys/devices/platform/coretemp.0/hwmon/hwmon3/temp1_input";
        }
      ];
    };
  };
}
