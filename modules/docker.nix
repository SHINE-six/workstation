{ config, pkgs, ... }:

{
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  
  virtualisation.docker.daemon.settings = {
    userland-proxy = false;
    # experimental = true;
    # metrics-addr = "0.0.0.0:9323";
    # ipv6 = true;
    # fixed-cidr-v6 = "fd00::/80";
  };
}