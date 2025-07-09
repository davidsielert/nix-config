# flakeModules/hosts.nix
{ self, inputs, lib, allOverlays, ... }:

let
  inherit (self) outputs;

  # ──────────────── 1. user directory ────────────────
  users = {
    dsielert = {
      avatar   = ./files/avatar/face;
      email    = "456592+davidsielert@users.noreply.github.com";
      fullName = "David Sielert";
      #gitKey   = "C5810093";
      name     = "dsielert";
      username = "dsielert";
    };
      };

  # helper to get a pkgs set with overlays + unfree
  pkgsFor = system: import inputs.nixpkgs {
    inherit system;
    overlays = allOverlays;
    config.allowUnfree = true;
  };

  # ──────────────── 2. builders ──────────────────────
  mkNixosConfiguration = hostname: username:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs hostname;
        userConfig   = users.${username};
        nixosModules = "${self}/modules/nixos";
      };
      modules = [ ./hosts/${hostname} ];
    };

  mkDarwinConfiguration = hostname: username:
    inputs.darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = {
        inherit inputs outputs hostname;
        userConfig = users.${username};
      };
      modules = [
        ../hosts/${hostname}
        inputs.home-manager.darwinModules.home-manager
        ({ ... }: {
          # pass common args to HM modules
          home-manager.extraSpecialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
        })
      ];
    };

  mkHomeConfiguration = system: username: hostname:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsFor system;
      extraSpecialArgs = {
        inherit inputs outputs hostname;
        userConfig = users.${username};
        dsModules  = "${self}/modules/home-manager";
      };
      modules = [ ./../home/${username}/${hostname} ];
    };
in
{
  ######################################################################
  ## flake outputs (flake-parts style)
  ######################################################################
  flake.darwinConfigurations = {
    mbp14 = mkDarwinConfiguration "mbp14" "dsielert";
  };

  flake.nixosConfigurations = {
    # energy       = mkNixosConfiguration "energy" "nabokikh";
    # nabokikh-z13 = mkNixosConfiguration "nabokikh-z13" "nabokikh";
  };

  flake.homeConfigurations = {
    "dsielert@mbp14" = mkHomeConfiguration "aarch64-darwin" "dsielert" "mbp14";
  };

  ######################################################################
  ## make overlays list available to other modules
  ######################################################################
  #_module.args.allOverlays = allOverlays;
  #overlays = import ./overlays {inherit inputs;};
}
