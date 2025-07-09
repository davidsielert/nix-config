{
  description = "David Siellerts * cross-platform Nix configuration";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org?priority=10"
      #"https://mirrors.ustc.edu.cn/nix-channels/store"
      #"https://cache.nixos.org"
      "https://nyx.chaotic.cx"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:iH5YI1D3vds8ILsPzQXTrCG/tvY1pG+sGbGjfm6u5gI="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" 

    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

         # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };


    flake-parts.url = "github:hercules-ci/flake-parts";
    mac-app-util.url = "github:hraban/mac-app-util";
    systems.url = "github:nix-systems/default-darwin";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";
    biome-pinned = {
      # use the exact commit
      url = "github:NixOS/nixpkgs/fb80ed6efd437ac2ef2f98681d8a06c08fc5966e";
      };
};
outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      ### 1. global settings ##############################################
      systems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];

      perSystem = { pkgs, ... }: {
        formatter = pkgs.alejandra;
      };

      ### 2. pull your own sub-modules in #################################
      imports = [
        # every file in flakeModules/ is a normal flake-parts module
        ./flakeModules/overlays.nix     # ← if you want
        ./flakeModules/hosts.nix        # ← emits all *Configurations
      ];
    };

}
