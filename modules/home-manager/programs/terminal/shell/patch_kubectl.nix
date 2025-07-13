{
  config,
  pkgs,
  lib,
  ...
}: let
  # The corrected version of the plugin’s conf-d file
  kubectlFishPatched = ''
    # patched blackjid/plugin-kubectl for Fish

    # resolve Fisher’s config dir (same logic as plugin)
    set -q fisher_path; or set -l fisher_path $__fish_config_dir

    if test -f $fisher_path/functions/__kubectl.init.fish
        source $fisher_path/functions/__kubectl.init.fish
    end
    __kubectl.init
  '';
in {
  # Overwrite the original file produced by Fisher/Nix
  home.file."${config.xdg.configHome}/fish/conf.d/plugin-kubectl2.fish".text = lib.mkForce kubectlFishPatched;
}
