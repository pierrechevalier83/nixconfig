# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Fonts
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        monospace = [ "Source Code Pro" ];
        sansSerif = [ "Source Sans Pro" ];
        serif     = [ "Source Serif Pro" ];
      };
    };
  };

  # Pulseaudio
  hardware = {
    pulseaudio.enable=true;
    cpu.intel.updateMicrocode = true;
    enableAllFirmware = true;
  };
  boot.extraModprobeConfig = ''
    options snd_soc_sst_bdw_rt5677_mach index=0
    options snd-hda-intel index=1
  '';

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pixel"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # For sublime and others
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    google-chrome
    gnome3.gnome_session
    gnome3.caribou # should come with gnome 3 but doesn't
    gnome3.polari
    sublime3 vim
    git clang gcc
    zsh
    nix-zsh-completions
    zsh-git-prompt
    deer
    numix-solarized-gtk-theme
    numix-icon-theme arc-icon-theme elementary-icon-theme
    mpv
    transmission transmission_gtk
    libreoffice-fresh
    pavucontrol
    pciutils
    iw
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
  };
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall to connect to chromecasts.
  networking.firewall.allowedTCPPorts = [ 8008 8009 ];
  networking.firewall.allowedUDPPortRanges = [ { from = 32768; to = 61000;} ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";
  services.xserver.xkbModel = "chromebook";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.clickMethod = "buttonareas";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # Shell
  environment.shells = [
    "/run/current-system/sw/bin/zsh"
  ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pierre = {
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
