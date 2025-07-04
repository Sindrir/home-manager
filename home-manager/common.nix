{ config, pkgs, inputs, ... }:

{
  xdg = {
    enable = true;
    mime.enable = true;
  };
  #targets.genericLinux.enable = true;
  #nixpkgs.allowUnfreePredicate = _: true;

  home = {
    username = "sindreo";
    homeDirectory = "/home/sindreo";
    stateVersion = "25.05";
    packages = with pkgs; [
      # CLI
      wget
      eza
      bat
      neofetch
      atuin
      kubectl
      git
      gitui
      lazygit
      networkmanagerapplet

      # Shell
      fish
      oh-my-fish
      starship

      ## Shell extras
      zoxide
      fzf
      yazi

      ## LSP
      kotlin-language-server
      lua-language-server
      marksman # Markdowm
      nil # Nix
      nixpkgs-fmt # Nix formatting

      # GUI applications
      ## Comms
      teams-for-linux
      slack
      vesktop # Discord client with proper wayland support

      ## Gaming
      #steam

      ## Music
      spotify

      ## General
      nordpass # Password manager

      # Programming
      ## Editors
      vim
      helix
      neovim
      zed-editor
      jetbrains-toolbox

      ## DB
      mongodb-compass

      ## Docker
      docker
      docker-compose

      ## notes
      obsidian

      ## File sync
      megasync

      ## Sound settings
      pavucontrol
    ];
    file = {
       ".config/fish".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/config/fish;
       ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/config/wezterm;
       ".config/helix".source = config.lib.file.mkOutOfStoreSymlink ./dotfiles/config/helix;
    };
    sessionVariables = {
      EDITOR = "hx";
      BROWSER = "firefox";
    };
  };
  programs = {
    home-manager.enable = true;
    wezterm = {
      enable = true;
      #package = (config.lib.nixGL.wrap inputs.wezterm.packages.${pkgs.system}.default);
      package = inputs.wezterm.packages.${pkgs.system}.default;
    };
    bottom.enable = true;
  };
  #nixGL = {
  #  packages = import nixgl {inherit pkgs;};
  #  defaultWrapper = "mesa";
  #  offloadWrapper = "nvidiaPrime";
  #  installScripts = [ "mesa" "nvidiaPrime" ];
  #};
}
