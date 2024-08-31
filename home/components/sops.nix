{inputs, config, ...}:
let
  home_dir = config.home.homeDirectory;
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${home_dir}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "user_private_keys/user" = {
        path = "${home_dir}/.ssh/id_ed25519";
      };
    }
  };
}
