{lib, ...}: {
  home.file.".config/fish/conf.d/plugin-kubectl.fish" = lib.mkForce {
    # <- mkForce here!
    text = ''
      # patched blackjid/plugin-kubectl

      set -q fisher_path; or set -l fisher_path $__fish_config_dir

      if test -f $fisher_path/functions/__kubectl.init.fish
          source $fisher_path/functions/__kubectl.init.fish
          if functions -q __kubectl.init
              __kubectl.init
          end
      end
    '';
  };
}
