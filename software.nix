{pkgs, ...}:
{
  # For sublime and others
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vlc
    avahi
    exa
    wget
    gutenprint
    google-chrome
    gnome3.gnome_session
    gnome3.polari
    sublime3
    neovim
    vim_configurable
    git clang gcc
    zsh
    nix-zsh-completions
    zsh-git-prompt
    deer
    firefox-bin
    numix-solarized-gtk-theme
    numix-icon-theme
    arc-icon-theme
    elementary-icon-theme
    mpv
    transmission_gtk
    libreoffice-fresh
    pavucontrol
    pciutils
    iw
    cmake
    boost
    clang
    llvm
    ninja
    # Vim config
    (
        with import <nixpkgs> {};
        vim_configurable.customize {
        name = "nvim";
        vimrcConfig.customRC = ''
            set expandtab
            set shiftwidth=4
            set softtabstop=4
            set shiftround
            set clipboard=unnamed
            set list
            set listchars=...
        '';
        vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
        vimrcConfig.vam.pluginDictionaries = [
          { names = [
            "Syntastic"
            "ctrlp-vim"
            "vim-nix"
            "YouCompleteMe"
            "clang_complete"
            "vim-markdown"
          ]; }
        ]; }
    )
  ];
}