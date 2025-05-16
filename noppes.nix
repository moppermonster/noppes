{ lib, pkgs, ... }:

let
noppes_app_launcher = pkgs.writeShellScriptBin "noppes_app_launcher" (builtins.readFile ./bin/noppes_app_launcher.sh);
in 
{
  services.xserver.windowManager.openbox.enable = true;
  environment.systemPackages = with pkgs; [
    # ---- base system ----
    acpi
    conky
    feh
    jgmenu
    networkmanagerapplet
    pavucontrol
    stalonetray
    volumeicon
    # ---- user apps ----
    gcompris
    nestopia-ue
    snes9x
    # ---- noppes apps ----
    noppes_app_launcher
  ];

  environment.etc = {
    "xdg/openbox/rc.xml".source = ./etc/xdg/openbox/rc.xml;
    "xdg/openbox/menu.xml".source = ./etc/xdg/openbox/menu.xml;
    "xdg/jgmenu/jgmenurc".source = ./etc/xdg/jgmenu/jgmenurc;
    "xdg/conky/conkyrc".source = ./etc/xdg/conky/conkyrc;
    "xdg/autostart/conky.desktop".source = ./etc/xdg/autostart/conky.desktop;
    "xdg/autostart/feh.desktop".source = ./etc/xdg/autostart/feh.desktop;
    "xdg/autostart/stalonetray.desktop".source = ./etc/xdg/autostart/stalonetray.desktop;
    "xdg/autostart/volumeicon.desktop".source = ./etc/xdg/autostart/volumeicon.desktop;
  };
}

