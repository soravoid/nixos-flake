{lib, ...}:
{
  disko.devices.disk = lib.genAttrs [ "0" "1" ] (name: {
    type = "disk";
    device = "/dev/nvme${name}n1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "1G";
          type = "EF00";
          content = {
            type = "mdraid";
            name = "boot";
          };
        };
        mdadm = {
          size = "100%";
          content = {
            type = "mdraid";
            name = "root";
          };
        };
      };
    };
  });
  disko.devices.mdadm = {
    boot = {
      type = "mdadm";
      level = 1;
      metadata = "1.0";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/efi";
        mountOptions = [
          "defaults"
          "dmask=0077"
          "fmask=0077"
        ];
      };
    };
    root = {
      type = "mdadm";
      level = 0;
      content = {
        type = "luks";
        name = "cryptroot";
        passwordFile = "/tmp/secret.key";
        settings.allowDiscards = true;
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/@" = {
              mountpoint = "/";
              mountOptions = [ "compress-force=zstd" "space_cache=v2" "relatime" ];
            };
            "/@var" = {
              mountpoint = "/var";
              mountOptions = [ "compress-force=zstd" "space_cache=v2" "relatime" ];
            };
            "/@vartmp" = {
              mountpoint = "/var/tmp";
              mountOptions = [ "compress-force=zstd" "space_cache=v2" "relatime" ];
            };
            "/@home" = {
              mountpoint = "/home";
              mountOptions = [ "compress-force=zstd" "space_cache=v2" "relatime" ];
            };
            "/@nix" = {
              mountpoint = "/nix";
              mountOptions = [ "compress-force=zstd" "space_cache=v2" "noatime" ];
            };
            "/@swap" = {
              mountpoint = "/swap";
              swap.swapfile.size = "4G";
            };
          };
        };
      };
    };
  };
}
