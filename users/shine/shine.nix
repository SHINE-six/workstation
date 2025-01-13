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
    extraGroups = [ "wheel" "networkmanager" ]; # Add user to wheel for sudo
    packages = with pkgs; [
      # 
    ];
  };

  programs.zsh.enable = true;

  # Import home-manager configuration
  home-manager.users.${userName} = import ./home.nix { inherit config pkgs; };
}