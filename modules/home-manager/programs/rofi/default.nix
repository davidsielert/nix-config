{
  config,
  pkgs,
  ...
}: let
  rofi-themes = pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "master"; # You can pin this to a specific commit hash for reproducibility
    sha256 = "sha256-yMKpwxdwvp7ryz2XXunbjC/5ud9HHEDzyYRhM540958="; # Replace with the actual hash
  };
in {
  # ... your other home-manager configuration

  home.file.".config/rofi" = {
    source = rofi-themes + "/files";
    recursive = true; # This ensures the entire directory is linked
  };

  # ... your other home-manager configuration
}
