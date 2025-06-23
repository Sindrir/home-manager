{
  description = "My Pop Nix";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };
  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    allowUnfree = true;
    configModule = {
    # Add any custom options (and do feel free to upstream them!)
    # options = { ... };
      config.vim = {
        theme.enable = true;
        # and more options as you see fit...
      };
    };
    customNeovim = nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [configModule];
    };
  in {
    packages.${system}.my-neovim = customNeovim.neovim;
    homeConfigurations = {
      sindreo = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {home.packages = [customNeovim.neovim];}
          ./home-manager/home.nix
        ];
      };
    };
  };
}
