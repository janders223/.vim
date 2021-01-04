{
  description = "janders223 vim configuration";

  inputs.utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, utils }:

  utils.lib.simpleFlake {
    inherit self nixpkgs;
    name = "janders223-vim";
    overlay = ./overlay.nix;
    shell = ./shell.nix;
    systems = [ "x86_64-darwin" ];
  };
}

