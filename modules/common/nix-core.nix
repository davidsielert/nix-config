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
      trusted-users = [ "root" "dsielert" ];
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      # key published on https://app.cachix.org/cache/nix-community
      "nix-community.cachix.org-1:iH5YI1D3vds8ILsPzQXTrCG/tvY1pG+sGbGjfm6u5gI="
    ];
    };
    optimise.automatic = true;
    package = pkgs.nix;
  };

  
}
