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
  boot.resumeDevice = "/dev/disk/by-uuid/8781e422-f382-4250-859b-5a249da1c416";
  # boot.kernelParams = ["resume_offset=ef53"];
  # if above doesn't work, try this:
  boot.initrd.systemd.enable = true;
  powerManagement.enable = true;
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/8781e422-f382-4250-859b-5a249da1c416";
      priority = 0;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05";
}
