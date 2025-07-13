{
  config,
  pkgs,
  lib,
  ...
}: let
  target = "${config.xdg.configHome}/fish/conf.d/plugin-kubectl.fish";
in {
  # plugin stays in programs.fish.plugins
  # …

  ## patch AFTER Home-Manager links the original file
  home.activation.patchKubectl = lib.hm.dag.entryAfter ["linkGeneration"] ''
        if [ -e "${target}" ]
          # replace the broken 'source' line with a guarded version
          sed -i -e '/source .*__kubectl.init.fish/,+2c\
    set -q fisher_path; or set -l fisher_path $__fish_config_dir\n\
    if test -f $fisher_path/functions/__kubectl.init.fish\n\
        source $fisher_path/functions/__kubectl.init.fish\n\
        if functions -q __kubectl.init\n\
            __kubectl.init\n\
        end\n\
    end' "${target}"
        end
  '';
}
