#!@bash@/bin/bash
if [ ! -v GEM_PATH ]; then
  GEM_PATH=$(@coreutils@/bin/ls -d @bundler@/lib/ruby/gems/*)
fi
export GEM_PATH
exec @t@/bin/t "$@"
