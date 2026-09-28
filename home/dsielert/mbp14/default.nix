{nhModules, ...}: {
  imports = [
    "${nhModules}/common"
  ];
  programs.fish = {
    enable = true;
    shellInit = ''
      # Existing stuff…

      # MacTeX binaries
      fish_add_path /Library/TeX/texbin
    '';
  };
  # Enable home-manager
  programs.home-manager.enable = true;
  #programs.fish = {
  #  shellInit = ''
  #    set -gx EDITOR "nvim"
  #    fish_add_path /run/current-system/sw/bin
  #  '';
  #};
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
