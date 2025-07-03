{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    #nixgl = {
    #  url = "github:nix-community/nixGL";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs =
    inputs @ {
      #self,
      nixpkgs
    , nvf
    , wezterm
    , home-manager
    , #nixgl,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      #overlays = [inputs.nixgl.overlay];
      allowUnfree = true;
      allowUnfreePredicate = pkg: true;
      configModule = {
        config.vim = {
          theme.enable = true;
        };
      };
      customNeovim = nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [ configModule ];
      };
    in
    {
      packages.${system}.my-neovim = customNeovim.neovim;
      # use "nixos", or your hostname as the name of the configuration
      # it's a better practice than "default" shown in the video

      # NixOS 'nixos-rebuild --flake .#HOST
      nixosConfigurations.home-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/home-desktop/configuration.nix
          home-manager.nixosModules.default
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs;
              };
              useGlobalPkgs = true;
              users.sindreo = import ./home-manager/sindreo.nix;
            };
          }
        ];
      };

      # Standalone home-manager 'home-manager --flake .#USERNAME
      homeConfigurations = {
        sindreo = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs;
            #inherit nixgl;
          };
          modules = [
            { home.packages = [ customNeovim.neovim ]; }
            ./home-manager/sindreo.nix
          ];
        };
      };
    };
}
