{userConfig, ...}: {
# Install git via home-manager module
  programs.git = {
    enable = true;
    userName = userConfig.fullName;
    userEmail = userConfig.email;
# signing = {
#   key = userConfig.gitKey;
#   signByDefault = true;
# };
    delta = {
      enable = true;
      options = {
        keep-plus-minus-markers = true;
        light = false;
        line-numbers = true;
        navigate = true;
        width = 280;
      };
    };
    extraConfig = {
      pull.rebase = "true";
    };
  };

# Enable catppuccin theming for git delta
  catppuccin.delta.enable = true;
  extraConfig = {
    init.defaultBranch = "main";
    push.autoSetupRemote = true;
    pull.rebase = true;
  };
  aliases = {
# common aliases
    br = "branch";
    co = "checkout";
    st = "status";
    ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
    ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
    cm = "commit -m";
    ca = "commit -am";
    dc = "diff --cached";
    amend = "commit --amend -m";

# aliases for submodule
    update = "submodule update --init --recursive";
    foreach = "submodule foreach";
  };
                   }
