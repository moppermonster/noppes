{ lib, pkgs, ... }:


{
  # Enable the lightdm display manager
  services.xserver.displayManager.lightdm.enable = true;

  # Disable greeter user wallpapers
  services.xserver.displayManager.lightdm.greeters.gtk.extraConfig = ''
    user-background = false
  '';

  # Set greeter wallpaper
  services.xserver.displayManager.lightdm.background = ./wallpaper.jpg;
}

