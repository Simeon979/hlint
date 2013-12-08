#!/bin/bash -e -x
rm -f dist/*.tar.gz
rm -rf dist/snapshot
cabal configure --ghc-options=-Werror
cabal sdist
cd dist
mkdir snapshot
tar -xf *.tar.gz -C snapshot
cd snapshot
mv hlint-* hlint # predictable name
cd hlint
cabal configure --ghc-options=-Werror
cabal build
cd ../../..
ghc-pkg expose transformers
hlint_datadir=data dist/snapshot/hlint/dist/build/hlint/hlint --test
