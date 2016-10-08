let nixpkgs = import <nixpkgs> {};
in { bash ? nixpkgs.bash
   , coreutils ? nixpkgs.coreutils
   , fetchurl ? nixpkgs.fetchurl
   , jre ? nixpkgs.jre
   , stdenv ? nixpkgs.stdenv
   }:
   stdenv.mkDerivation {
     name = "tagsoup-1.2.1";
     tagsoupjar = fetchurl {
        url = http://central.maven.org/maven2/org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar;
        sha256 = "ac97f7b4b1d8e9337edfa0e34044f8d0efe7223f6ad8f3a85d54cc1018ea2e04";
     };
     script = ./tagsoup;
     inherit bash
             coreutils
             jre;
     builder = builtins.toFile "builder.sh"
       ''
       source "$stdenv/setup"
       mkdir -p "$out/bin" "$out/lib"
       cp "$tagsoupjar" "$out/lib/tagsoup.jar"
       substituteAll "$script" "$out/bin/tagsoup"
       chmod +x "$out/bin/tagsoup"
       '';
   }
