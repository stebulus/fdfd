let nixpkgs = import <nixpkgs> {};
in { awk ? nixpkgs.gawk
   , bash ? nixpkgs.bash
   , coreutils ? nixpkgs.coreutils
   , curl ? nixpkgs.curl.bin
   , grep ? nixpkgs.gnugrep
   , jena ? nixpkgs.apache-jena
   , sed ? nixpkgs.gnused
   , stdenv ? nixpkgs.stdenv
   , xml2 ? nixpkgs.xml2
   }:
   stdenv.mkDerivation {
     name = "fdfd-0.1.0";
     src = ./.;
     inherit awk
             bash
             coreutils
             curl
             grep
             jena
             sed
             xml2;
     scripts = [ "fdfd" ];
     builder = builtins.toFile "builder.sh"
       ''
       source "$stdenv/setup"
       mkdir -p "$out/bin"
       for f in $scripts; do
         substituteAll "$src/$f" "$out/bin/$f"
         chmod +x "$out/bin/$f"
       done
       mkdir -p "$out/lib"
       cp "$src"/lib/* "$out/lib"
       '';
   }
