{
  inputs,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    EDITOR = "nvim"; # Or "vim", "emacs", "code -w", etc.
  };
  home.packages = with pkgs; [
    wakatime-cli
  ];
  programs.fish = {
    enable = true;
    #useBabelfish = true;
    plugins = with pkgs; [
      {
        name = "bass";
        src = fishPlugins.bass;
      }
      {
        name = "fzf";
        src = fishPlugins.fzf;
      }
      {
        name = "z";
        src = fishPlugins.z;
      }
      {
        name = "wakatime";
        src = fishPlugins.wakatime-fish;
      }
      {
        name = "kubectl";
        src = pkgs.fetchFromGitHub {
          owner = "davidsielert";
          repo = "plugin-kubectl";
          rev = "78c4ec5b71fd5b7a1ea687fc3d6c9b24f28d96c4";
          sha256 = "sha256-vC8om7LI3+rxd8+u4yiimz9UBywyM/BI5X92rW0aB5A=";
        };
      }
      {
        name = "tmux";
        src = pkgs.fetchFromGitHub {
          owner = "budimanjojo";
          repo = "tmux.fish";
          rev = "v2.0.1";
          sha256 = "sha256-ynhEhrdXQfE1dcYsSk2M2BFScNXWPh3aws0U7eDFtv4=";
        };
      }
    ];
    loginShellInit = let
      # We should probably use `config.environment.profiles`, as described in
      # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-1659465635
      # but this takes into account the new XDG paths used when the nix
      # configuration has `use-xdg-base-directories` enabled. See:
      # https://github.com/LnL7/nix-darwin/issues/947 for more information.
      profiles = [
        "/etc/profiles/per-user/$USER" # Home manager packages
        "$HOME/.nix-profile"
        "(set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)/nix/profile"
        "/run/current-system/sw"
        "/nix/var/nix/profiles/default"
      ];

      makeBinSearchPath =
        lib.concatMapStringsSep " " (path: "${path}/bin");
    in ''
      # Fix path that was re-ordered by Apple's path_helper

      # fish_add_path --move --prepend --path ${makeBinSearchPath profiles}
      # set fish_user_paths $fish_user_paths

    '';
    interactiveShellInit = ''

      status is-interactive; and begin
        set fish_tmux_autostart true
      end
        # ~/.config/fish/config.fish
        set -gx HOMEBREW_PREFIX /opt/homebrew
        set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
        set -gx HOMEBREW_REPOSITORY /opt/homebrew
    '';
    functions = {
      auto_activate_venv = {
        body = ''
          # Get the top-level directory of the current Git repo (if any)
          set REPO_ROOT (git rev-parse --show-toplevel 2>/dev/null)

          # Case #1: cd'd from a Git repo to a non-Git folder
          #
          # There's no virtualenv to activate, and we want to deactivate any
          # virtualenv which is already active.
          if test -z "$REPO_ROOT"; and test -n "$VIRTUAL_ENV"
              deactivate
          end

          # Case #2: cd'd folders within the same Git repo
          #
          # The virtualenv for this Git repo is already activated, so there's
          # nothing more to do.
          if [ "$VIRTUAL_ENV" = "$REPO_ROOT/.venv" ]
              return
          end

          # Case #3: cd'd from a non-Git folder into a Git repo
          #
          # If there's a virtualenv in the root of this repo, we should
          # activate it now.
          if [ -d "$REPO_ROOT/.venv" ]
              source "$REPO_ROOT/.venv/bin/activate.fish" &>/dev/null
          end
        '';
        description = "Auto-activate virtualenv when changing directories";
        onVariable = "PWD";
      };
      cdg = {
        body = ''
          set root (git rev-parse --show-toplevel ^/dev/null)
          if test -n "$root"
            cd $root
          else
            echo "Not in a Git repository"
          end
        '';
      };
    };
    shellAliases = {
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza -lT"; # Tree view
      l = "eza -lh"; # Human-readable sizes
    };
  };
  programs.nushell = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = lib.mkBefore ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      ZSH_TMUX_AUTOSTART=''${ZSH_TMUX_AUTOSTART:-true}
      ZSH_TMUX_AUTOSTART_ONCE=true
      ZSH_TMUX_DEFAULT_SESSION_NAME=main
      DISABLE_AUTO_UPDATE=true
      DISABLE_UPDATE_PROMPT=true

    '';
    #zplug = {
    #  enable = true;
    #  plugins = [
    #    {name = "MichaelAquilina/zsh-autoswitch-virtualenv";}
    #  ];
    #};
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aliases"
        "tmux"
        "virtualenvwrapper"
      ];
    };
    envExtra = ''
      export WORKON_HOME="/Users/dsielert/.virtualenvs"; # Replace with your desired path
      export VIRTUALENVWRAPPER_PYTHON="${pkgs.python3}/bin/python3"
      export VIRTUALENVWRAPPER_VIRTUALENV="${pkgs.python3Packages.virtualenv}/bin/virtualenv"
    '';
  };

  home.shellAliases = {
    k = "kubectl";
    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
  programs.tmux = {
    enable = true;
    # shell = "\${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -gu default-command
      set -g default-shell "\${pkgs.fish}/bin/fish"
    '';

    keyMode = "vi";
    mouse = true;

    plugins = with pkgs; [
      tmuxPlugins.yank
      tmuxPlugins.dracula
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.tmux-fzf
    ];
  };
}
