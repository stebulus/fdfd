let nixpkgs = import <nixpkgs> {};
in { bash ? nixpkgs.bash
   , coreutils ? nixpkgs.coreutils
   , curl ? nixpkgs.curl.bin
   , grep ? nixpkgs.gnugrep
   , redland ? nixpkgs.redland
   , sed ? nixpkgs.gnused
   , stdenv ? nixpkgs.stdenv
   }:
   stdenv.mkDerivation {
     name = "fdfd-0.1.0";
     src = ./.;
     inherit bash
             coreutils
             curl
             grep
             redland
             sed;
     scripts = [ "fdfd" ];
     builder = builtins.toFile "builder.sh"
       ''
       source "$stdenv/setup"
       mkdir -p "$out/bin"
       for f in $scripts; do
         substituteAll "$src/$f" "$out/bin/$f"
         chmod +x "$out/bin/$f"
       done
       '';
   }
