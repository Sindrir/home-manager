# users.nix
{ config, pkgs, ...];

{
  users.users.sindreo = {
    isNormalUser  = true;
    description  = "Sindre Østrem";
    extraGroups  = [ "wheel" "networkmanager" "docker" ];
    uid = 1000;
  };
}
