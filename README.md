NOTES:
- between type families and functional dependencies https://github.com/purescript/purescript/issues/1580#issuecomment-160833460

```
module Main where

import Prelude
import Control.Monad.Eff.Console (log)
import TryPureScript (render, withConsole)

type Pair a b = {fst :: a, snd :: b}

fst :: forall a b. Pair a b -> a
fst = _.fst

snd :: forall a b. Pair a b -> b
snd = _.snd

swap :: forall a b. Pair a b -> Pair b a
swap p = {fst: snd p, snd: fst p}

class FromPair a e | a -> e where
    fromPair :: Pair e e -> a

instance fromPairArray :: FromPair (Array e) e where
    fromPair p = [fst p, snd p]


main = render =<< withConsole do
  log $ show $ (fromPair { fst: 1, snd: 2 } :: Array Int)
```

- http://notes.asaleh.net/posts/experimenting-with-purescripts-rowtolist-metaprogramming/
- lenses generator https://github.com/paf31/purescript-derive-lenses + https://github.com/input-output-hk/cardano-sl/blob/develop/explorer/frontend/README.md#2-generate-lenses

TODO:
1. try async https://github.com/purescript/purescript-parallel/blob/v4.0.0/src/Control/Parallel/Class.purs#L62
2. try dynatic extensiable rows builder

```
type alias HasX a = { a | x :: Int }
type alias HasY a = { a | y :: Int }
type alias Positional a = { a | x :: Int, y :: Int }

mergeRecordDefs HasX HasY :: Positional
```
