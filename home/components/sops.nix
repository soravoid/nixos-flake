{inputs, config, ...}:
let
  home_dir = config.home.homeDirectory;
in
{
  sops = {
    age.keyFile = "${home_dir}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "user_private_keys/user" = {
        path = "${home_dir}/.ssh/id_github_rw";
      };
      "ssh_signing_key" = {
        path = "${home_dir}/.ssh/id_github_sign";
      };
    };
  };
}
