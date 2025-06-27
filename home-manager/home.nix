{ config, pkgs, inputs, nixgl, ... }:

{
  xdg.enable=true;
  xdg.mime.enable=true;
  targets.genericLinux.enable=true;
  nixpkgs.config.allowUnfreePredicate = _: true;
  home.username = "sindreo";
  home.homeDirectory = "/home/sindreo";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    neofetch
    atuin
    jetbrains.idea-ultimate
    helix
    neovim
    kubectl
    git
    teams-for-linux
    slack
    fish
    oh-my-fish
    yazi
    obsidian
    fzf
    zoxide
    lazygit
    kotlin-language-server
    lua-language-server
    marksman
    nil
    nixpkgs-fmt
  ];
  programs.home-manager.enable = true;
  nixGL.packages = import nixgl { inherit pkgs; };
  nixGL.defaultWrapper = "mesa";  # Default wrapper for general use
  nixGL.offloadWrapper = "nvidiaPrime";  # Wrapper for NVIDIA GPU offloading
  nixGL.installScripts = [ "mesa" "nvidiaPrime" ];
  programs.wezterm = {
    enable = true;
    package = (config.lib.nixGL.wrap inputs.wezterm.packages.${pkgs.system}.default);
  };
  home.file.".config/wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink /home/sindreo/nix/home-manager/dotfiles/wezterm.lua;
  home.file.".config/helix/config.toml".source = config.lib.file.mkOutOfStoreSymlink /home/sindreo/nix/home-manager/dotfiles/helix/config.toml;
  home.file.".config/helix/languages.toml".source = config.lib.file.mkOutOfStoreSymlink /home/sindreo/nix/home-manager/dotfiles/helix/languages.toml;
  home.shellAliases = {
    k = "kubectl";
  };
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "firefox";
  };
}
