{ config
, lib
, modulesPath
, inputs
, ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./components/sops.nix
  ];

  networking.hostName = "asrock";
  services.pipewire.alsa.support32Bit = lib.mkBefore true;

  # Kernel module for TP-LINK USB WiFi Adapter
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8852au ];
  # Needed for USB WiFi adapter to work
  hardware.usb-modeswitch.enable = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    # remotePlay.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;

    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;
  programs.gamemode.settings = {
    gpu = {
      apply_gpu_optimisations = "accept-responsibility";
      gpu_device = 1;
      amd_performance_level = "auto";
    };
  };
  users.users.user.extraGroups = [
    "gamemode"
  ];

  ########## COPIED FROM HARDWARE SCAN ##########
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  # boot.extraModulePackages = [ ];
  hardware.firmware = [ ];
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
