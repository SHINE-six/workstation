{ config, pkgs, ...}:

{
  networking.firewall.allowedTCPPorts = [
    6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
    # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
    # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
  ];
  networking.firewall.allowedUDPPorts = [
    # 8472 # k3s, flannel: required if using multi-node for inter-node networking
  ];
  # Disable since date: 2025-06-17
  # services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # "--debug" # Optionally add additional args to k3s
  ];

  imports = [
    ./projecttwin/projecttwin.nix
  ];

  # multi-node setup
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  #   token = "<randomized common secret>";
  #   clusterInit = true;
  # };
}
