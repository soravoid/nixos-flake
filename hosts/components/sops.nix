{ inputs, config, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "user_age_keys/user" = {
        owner = config.users.users.user.name;
        inherit (config.users.users.user) group;
        path = "/home/user/.config/sops/age/keys.txt";
      };
    };
  };
}
