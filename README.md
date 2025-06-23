# Install nix

```shell
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

# Init home manager
```shell
nix run home-manager/master -- init --switch
```

# First build

```shell
nix run nixpkgs#home-manager -- switch --flake <flake-file-path>#<USERNAME>
```

# Subsequent builds

```shell
home-manager switch --flake nix/#$USER
```
