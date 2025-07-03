{ config, pkgs, inputs, ... }:

{
  xdg = {
    enable = true;
    mime.enable = true;
  };
  targets.genericLinux.enable = true;
  #nixpkgs.allowUnfreePredicate = _: true;
  home = {
    username = "sindreo";
    homeDirectory = "/home/sindreo";
    stateVersion = "25.05";
    packages = with pkgs; [
      # CLI
      vim
      wget
      starship
      eza
      bat
      neofetch
      atuin
      kubectl
      git
      lazygit
      zoxide
      fzf
      yazi
      fish
      oh-my-fish

      # Terminal editors
      helix
      neovim

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

      ## Programming
      #jetbrains.idea-ultimate

      ## notes
      obsidian

      ## File sync
      megasync

      ## Sound settings
      pavucontrol
    ];
    file = {
      ".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home-manager/dotfiles/wezterm.lua;
      ".config/helix/config.toml".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home-manager/dotfiles/helix/config.toml;
      ".config/helix/languages.toml".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/home-manager/dotfiles/helix/languages.toml;
    };
    shellAliases = {
      k = "kubectl";
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
    fish = {
      shellAliases = {
        nurse = "sudo nixos-rebuild switch --flake /etc/nixos#home-desktop";
        tree = "eza --tree";
      };
    };
  };
  #nixGL = {
  #  packages = import nixgl {inherit pkgs;};
  #  defaultWrapper = "mesa";
  #  offloadWrapper = "nvidiaPrime";
  #  installScripts = [ "mesa" "nvidiaPrime" ];
  #};
}
