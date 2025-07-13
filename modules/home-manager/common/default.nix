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
    ../programs/aerospace
    ../programs/alacritty
    ../programs/atuin
    ../programs/bat
    ../programs/brave
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/go
    ../programs/gpg
    ../programs/k9s
    ../programs/krew
    ../programs/lazygit
    #../programs/neovim
    ../programs/obs-studio
    ../programs/saml2aws
    # ../programs/starship
    ../programs/telegram
    #j../programs/tmux
    ../programs/ulauncher
    #jku../programs/zsh
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
