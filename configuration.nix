# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
      ./samus.nix
      ./locales.nix
      ./software.nix
    ];

  # Latest kernel (obviously)
  boot.kernelPackages = pkgs.linuxPackages_4_14;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pixel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    promptInit = "POWERLEVEL9K_MODE=nerdfont-complete;\nsource ${pkgs.zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme";
  };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Aliases
  environment.shellAliases = {
    "ls" = "exa";
    "vim" = "nvim";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall to connect to chromecasts. 631 
  #networking.firewall.allowedTCPPorts = [ 631 8008 8009 631 ];
  #networking.firewall.allowedUDPPorts = [ 631 ];
  #networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 61000;} ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.avahi.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.xkbModel = "chromebook";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.clickMethod = "buttonareas";

  # Enable the Gnome Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # Shell
  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pierrec = {
    isNormalUser = true;
    home = "/home/pierrec";
    description = "Pierre Chevalier";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
  users.extraUsers.mariav = {
    isNormalUser = true;
    home = "/home/mariav";
    description = "Maria Viseu";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}
