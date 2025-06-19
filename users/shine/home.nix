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
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "qemu-libvirtd" "kvm" ]; # Add user to wheel for sudo
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
      btop
      wget
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
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true; # Enable oh-my-zsh
        plugins = [ "git" "docker" ]; # Add plugins
        theme = "robbyrussell"; # Set theme
      };
      shellAliases = {
        rb-nix = "sudo nixos-rebuild switch --flake ~/nixos-config/flake.nix#default";
        nix-generations = "nixos-rebuild list-generations";
      };
      sessionVariables = {
        DOCKER_HOST="unix:///run/user/$(id -u)/docker.sock";
        KUBECONFIG=/etc/rancher/k3s/k3s.yaml; 
      };
      # Custom zshrc
      initExtra = ''
        # Enable vcs_info for Git integration
        autoload -Uz vcs_info
        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )
        setopt prompt_subst

        # Configure vcs_info for Git
        zstyle ':vcs_info:git:*' formats ' %F{green}git:(%b)%f'
        zstyle ':vcs_info:git:*' actionformats ' %F{green}git:(%b|%a)%f'

        # Customize the prompt
        PROMPT='$(if [[ -n $SHELL_ENV ]]; then echo "%F{magenta}($(basename $SHELL_ENV)) "; fi)%F{cyan}%1~%f''${vcs_info_msg_0_}%F{cyan} %(!.#.$) %f'
      '';

    };

    programs.git = {
      enable = true;
      userName = "SHINE-six";
      userEmail = "desmondfoo0610@gmail.com";
      extraConfig = {
        credential.helper = "store"; # Store credentials in plaintext
      };
    };
  };
}