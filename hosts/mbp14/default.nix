{
  pkgs,
  outputs,
  userConfig,
  ...
}: {
  imports = [
    # Import the default mac settings
    ./../../modules/darwin/default.nix
    ./../../modules/common
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

  
  # User configuration
  users.users.${userConfig.name} = {
    name = "${userConfig.name}";
    home = "/Users/${userConfig.name}";
  };

 
  # Zsh configuration
  programs.zsh.enable = true;

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 6;
}
