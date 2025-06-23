{ config, pkgs, ... }:

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
    jetbrains.idea-ultimate
    helix
    neovim
    kubectl
    git
    teams-for-linux
    slack
    docker
    docker-compose
    fish
    oh-my-fish
    kitty
    yazi
  ];
  programs.home-manager.enable = true;
  home.shellAliases = {
    k = "kubectl"
  }
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  }
}
