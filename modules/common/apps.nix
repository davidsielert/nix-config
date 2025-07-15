{pkgs, ...}: {
  programs.neovim.enable = false;
  environment.systemPackages = with pkgs; [
    # neovim
    git
    just # use Justfile to simplify nix-darwin's commands
    llvmPackages.lldb
    zoxide
    nvim-pkg
  ];
}
