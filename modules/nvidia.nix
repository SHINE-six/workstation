{ config, pkgs, ... }:

{  
  # Nvidia settings
    # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  hardware.graphics.enable = true;
  hardware.nvidia-container-toolkit = {
    enable = true;
    # mount-nvidia-executables = true;
    # mount-nvidia-docker-1-directories = true;
  };
  hardware.nvidia = {
    open = true;
    nvidiaPersistenced = true;
    modesetting.enable = true;
    # Enable the Nvidia settings menu,
	  # accessible via nvidia-settings.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload.enable = true;
      
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}