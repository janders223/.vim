{pkgs ? import <nixpkgs> }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    dhall
    gitAndTools.gitFull
    jq
    shellcheck
  ];
}
