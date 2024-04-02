{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time Zone
  time.timeZone = "Australia/Perth";

  # Internationalisation Properties
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Define user accounts
  users.users.adam = {
    description = "Adam Brickhill";

    group = "users";
    extraGroups = [ "wheel" "networking" ];
    isNormalUser = true;
  };

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Installing Packages
  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [];

  # Services
  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "au";
    xkb.variant = "";

    desktopManager.xterm.enable = false;
    # displayManager.enable = false;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi # Application Launcher
      ];
    };
  };

  # Remote Desktop
  services.xrdp = {
    enable = true;
    openFirewall = true;
    defaultWindowManager = "i3";
  };
}