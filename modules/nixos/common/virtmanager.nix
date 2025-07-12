{pkgs-stable, ...}: {
  virtualisation.vmware.guest.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager = {
    enable = true;
    package = pkgs-stable.virt-manager;
  };
}
