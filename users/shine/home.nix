{ config, pkgs, ... }:

{
  home.stateVersion = "24.11"; # Match your NixOS version
  programs.zsh = {
    enable = true; # Enable zsh
    oh-my-zsh = {
      enable = true; # Enable oh-my-zsh
      plugins = [ "git" "docker" ]; # Add plugins
      theme = "robbyrussell"; # Set theme
    };
    shellAliases = {
      ll = "ls -la"; # Add aliases
      gs = "git status";
    };
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  home.packages = with pkgs; [
    firefox
    git
    tree
    jq
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        jnoortheen.nix-ide
        github.copilot
        github.copilot-chat
      ];
    })
  ];
}