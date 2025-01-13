{ config, pkgs, ... }:

let
  userName = "shine";
  home = "/home/${userName}";
in 
{
  # Define the user
  users.users.${userName} = {
    isNormalUser = true;
    description = userName;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Add user to wheel for sudo
  };
  programs.zsh.enable = true;


  home-manager.users.${userName} = {
    home.stateVersion = "24.11"; # Match your NixOS version

    home.packages = with pkgs; [
      firefox
      fastfetch
      zsh
      git
      tree
      jq
      kubernetes-helm
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          jnoortheen.nix-ide
          github.copilot
          github.copilot-chat
        ];
      })
    ];

    programs.zsh = {
      enable = true; # Enable zsh
      oh-my-zsh = {
        enable = true; # Enable oh-my-zsh
        plugins = [ "git" "docker" ]; # Add plugins
        theme = "robbyrussell"; # Set theme
      };
      shellAliases = {
        rb-nix = "sudo nixos-rebuild switch --flake ~/nixos-config/flake.nix#default";
        nix-generations = "nixos-rebuild list-generations";
        helm = "helm --kubeconfig /etc/rancher/k3s/k3s.yaml";
      };
      sessionVariables = {
        DOCKER_HOST="unix:///run/user/$(id -u)/docker.sock";
        # KUBECONFIG=/etc/rancher/k3s/k3s.yaml;
      };
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    programs.git = {
      enable = true; # Enable Git
      userName = "SHINE-six"; # Set Git username
      userEmail = "desmondfoo0610@gmail.com"; # Set Git email
    };
  };
}