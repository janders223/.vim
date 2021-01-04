{
  description = "janders223 vim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
  utils.lib.eachDefaultSystem (system:
  let

    pkgs = import nixpkgs { inherit system; };

    vimrc = builtins.readFile ./vimrc;

    vim-bettergrep = pkgs.vimUtils.buildVimPlugin {
      name = "vim-bettergrep";
      src = pkgs.fetchFromGitHub {
        owner = "qalshidi";
        repo = "vim-bettergrep";
        rev = "6db797d2a03efeee8fb4414c93a9016f6ccd38b8";
        sha256 = "01fa955mgn9p59sycp46g7vnw1h9v0xbszrz86j6hix51x7kzvzx";
      };
    };

    vim-lua = pkgs.vimUtils.buildVimPlugin {
      name = "vim-lua";
      src = pkgs.fetchFromGitHub {
        owner = "xolox";
        repo = "vim-lua-ftplugin";
        rev = "bcbf914046684f19955f24664c1659b330fcb241";
        sha256 = "18i1205hf2zz1ldjbdisaqknqqghh5wz59baplmxqnsm1wbrcb6n";
      };
    };

    vim-qf = pkgs.vimUtils.buildVimPlugin {
      name = "vim-qf";
      src = pkgs.fetchFromGitHub {
        owner = "romainl";
        repo = "vim-qf";
        rev = "23c9d67cdd0739c9d74ac9e4a494b7cb7351170c";
        sha256 = "15kj1wvd3wlmn982l2v8sv2lc3q39bz3jw94jvmkh7nz51xvmfqc";
      };
    };

  in rec {
    defaultPackage = pkgs.vim_configurable.customize {
      name = "janders223_vim";

      vimrcConfig.customRC = vimrc;

      vimrcConfig.packages.janders223 = with pkgs.vimPlugins; {
        start = [
          LanguageClient-neovim
          ctrlp-vim
          delimitMate
          indentLine
          nerdtree
          nord-vim
          tabular
          vim-airline
          vim-airline-themes
          vim-better-whitespace
          vim-bettergrep
          vim-commentary
          vim-endwise
          vim-fugitive
          vim-misc
          vim-qf
          vim-repeat
          vim-surround
          vim-tmux-navigator
        ];
        opt = [
          dhall-vim
          vim-json
          vim-lua
          vim-markdown
          vim-nix
          vim-terraform
          vim-toml
          vim-yaml
        ];
      };
    };

    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        defaultPackage
        dhall
        dhall-json
        # dhall-lsp-server
        gitAndTools.gitFull
        jq
        shellcheck
      ];
    };
  });
}

