{
  outputs,
  userConfig,
  pkgs,
  ...
}: {
  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];
  };
  imports = [
    ./apps.nix
    ../programs/git
    ../programs/terminal
    ../misc/qt
    ../programs/alacritty
    ../programs/atuin
    ../programs/bat
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    #    ../programs/go
    ../programs/gpg
    #    ../programs/k9s
    #    ../programs/krew
    ../programs/lazygit
    ../programs/obs-studio
    ../programs/saml2aws
    #j../programs/tmux
    #jku../programs/zsh
    ../programs/rofi
  ];

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${userConfig.name}"
      else "/home/${userConfig.name}";
  };
  catppuccin = {
    flavor = "mocha";
  };
}
