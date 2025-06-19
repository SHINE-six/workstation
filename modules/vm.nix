{ config, pkgs, ... }:

{
  # Virtualization setup
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "br0" ];
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
    };
  };

  # Networking configuration
  networking = {
    useDHCP = false;
    
    # Bridge configuration
    bridges = {
      br0 = {
        interfaces = [ "enp2s0" ];
      };
    };
    
    interfaces.br0.ipv4.addresses = [{
      address = "10.10.10.10";
      prefixLength = 24;
    }];

    # NAT configuration
    nat = {
      enable = true;
      internalInterfaces = [ "br0" ];
      externalInterface = "wlp4s0";
    };

    # Firewall settings
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 7050 7051 8080 ];
    };

    # Extra hosts for local resolution
    extraHosts = ''
      127.0.0.1 orderer.altenergyordererorg.com # Orderer running on host
      127.0.0.1 peer0.altenergyorg.com

      10.10.10.11 peer0.keysupplierorg.com 
    '';
  };

  # System settings
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };

  # Services
  services.openssh.enable = true;

  # Required packages
  environment.systemPackages = with pkgs; [
    gnome-boxes
    virt-manager
  ];
}
