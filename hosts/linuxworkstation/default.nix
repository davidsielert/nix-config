{
  inputs,
  hostname,
  nixosModules,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./../../modules/common
    "${nixosModules}/common"
    "${nixosModules}/desktop/hyprland"
  ];
  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
      outputs.overlays.neovim-overlay
    ];

    config = {
      allowUnfree = true;
    };
  };

  # Set hostname
  networking.hostName = hostname;
  # Set Parameters required for hibernation
  # boot.kernelParams = ["resume_offset=<offset>"];
  boot.resumeDevice = "/dev/disk/by-uuid/650d65ea-024a-4a1b-9f5e-d4816feda54f";
  powerManagement.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05";
}
