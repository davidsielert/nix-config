{
  pkgs,
  ...
}: {
  # enable flakes globally

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  
}
