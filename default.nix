let nixpkgs = import <nixpkgs> {};
in { bash ? nixpkgs.bash
   , redland ? nixpkgs.redland
   , stdenv ? nixpkgs.stdenv
   }:
   stdenv.mkDerivation {
     name = "fdfd-0.1.0";
     src = ./.;
     inherit bash
             redland;
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
