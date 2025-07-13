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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05";
}
