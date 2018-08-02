{ config, pkgs, ... }:

{
  boot = {
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda";
    };
    kernelModules = [ "snd-seq" "snd-rawmidi" ];
    kernelParams = [ "threadirq" ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    alsaLib
    binutils
    clang_5
    cmake
    git
    gnome3.gnome-tweak-tool
    htop
    libcxx
    libcxxabi
    libjack2
    llvmPackages.libcxxClang
    llvmPackages.libcxxStdenv
    ninja
    python2
    python3
    qjackctl
    tmux
    vim
    wget
    zsh
  ];

  programs = {
    bash.enableCompletion = true;
    gnupg.agent = { enable = true; enableSSHSupport = true; };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      syntaxHighlighting.highlighters = [ "main" "brackets" "cursor" "root" "line" ];
      enableAutosuggestions = true;
    };
  };

  services = {
    openssh.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
      desktopManager.gnome3.enable = true;
      desktopManager.default = "gnome3";
    };
  };

  users.extraUsers.nick = {
    isNormalUser = true;
    createHome = true;
    home = "/home/nick";
    shell = "${pkgs.zsh}/bin/zsh";
    uid = 1000;
    extraGroups = [ "wheel" "audio" ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?
}
