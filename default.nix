let nixpkgs = import <nixpkgs> {};
in { awk ? nixpkgs.gawk
   , bash ? nixpkgs.bash
   , bc ? nixpkgs.bc
   , coreutils ? nixpkgs.coreutils
   , curl ? nixpkgs.curl.bin
   , findutils ? nixpkgs.findutils
   , grep ? nixpkgs.gnugrep
   , jena ? nixpkgs.apache-jena
   , jq ? nixpkgs.jq
   , sed ? nixpkgs.gnused
   , stdenv ? nixpkgs.stdenv
   , xml2 ? nixpkgs.xml2
   }:
   stdenv.mkDerivation {
     name = "fdfd-0.1.0";
     src = ./.;
     inherit awk
             bash
             bc
             coreutils
             curl
             findutils
             grep
             jena
             jq
             sed
             xml2;
     scripts = [ "extract-atom"
                 "extract-rss"
                 "fdfd"
                 "fetch"
                 "xml2-pieces" ];
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
