{ config, pkgs, ... }:

{
  networking.extraHosts = ''
    127.0.0.1 redpanda-console.projecttwin.com
    127.0.0.1 api.projecttwin.com
    # 127.0.0.1 kubernetes-dashboard.projecttwin.com
  '';
}