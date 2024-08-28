{
  description = "Set up NixOS for personal use.";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, disko, home-manager, ...}:
  {
    nixosConfigurations =
      let
        system = "x86_64-linux";
      in
      {
        thinkpadx1 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./disk-configs/disk-config-thinkpadx1.nix
            ./configuration.nix
            ./hosts/thinkpadx1.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.user = import ./home-user.nix;
            }
          ];
        };
        asrock = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./disk-configs/disk-config-asrock.nix
            ./configuration.nix
            ./hosts/thinkpadx1.nix
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.user = import ./home-user.nix;
            }
          ];
        };
      };
  };
}
