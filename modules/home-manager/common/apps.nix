{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg
    mprocs
    # productivity
    glow # markdown previewer in terminal
    zoxide
    nodejs_22

    zsh-autoenv
    zsh-autocomplete
    awscli2
    (python3.withPackages (
      p:
        with p; [
          boto3
          pandas
          numpy
          #virtualenvwrapper
        ]
    ))
    python3Packages.virtualenvwrapper
    poetry
    uv
    rke
    nixpkgs-fmt
    alejandra
    fastfetch
    ghostty
    stylua
    mercurial
    tree-sitter
    gh
    fd
    clang
    cmake
    ninja
    wakatime-cli
  ];
  programs = {
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };
  };
}
