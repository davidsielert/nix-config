{
  config,
  lib,
  ...
}: let
  target = "${config.xdg.configHome}/fish/conf.d/plugin-kubectl.fish";
in {
  home.activation.patchKubectl = lib.hm.dag.entryAfter ["linkGeneration"] ''
          #!/usr/bin/env bash
          set -euo pipefail

          if [[ -e "${target}" ]]; then
            # Replace the broken “source” line with a guarded version.
            sed -i '/source .*__kubectl.init.fish/,+2c\
    set -q fisher_path; or set -l fisher_path $__fish_config_dir\n\
    if test -f $fisher_path/functions/__kubectl.init.fish\n\
        source $fisher_path/functions/__kubectl.init.fish\n\
        if functions -q __kubectl.init\n\
            __kubectl.init\n\
        end\n\
    end' "${target}"
          fi
  '';
}
