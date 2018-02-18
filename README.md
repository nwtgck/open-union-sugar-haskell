# open-union-sugar

| branch | status|
| --- | --- |
| [`master`](https://github.com/nwtgck/open-union-sugar-haskell/tree/master) | [![Build Status](https://travis-ci.org/nwtgck/open-union-sugar-haskell.svg?branch=master)](https://travis-ci.org/nwtgck/open-union-sugar-haskell) |
| [`develop`](https://github.com/nwtgck/open-union-sugar-haskell/tree/develop) | [![Build Status](https://travis-ci.org/nwtgck/open-union-sugar-haskell.svg?branch=develop)](https://travis-ci.org/nwtgck/open-union-sugar-haskell) |

Syntactic sugar for [open-union](https://hackage.haskell.org/package/open-union)

## Install

Add this library to `extra-deps` in your `stack.yaml` like the following if you use [Stack](https://docs.haskellstack.org/en/stable/README/).

```yaml
...
extra-deps:
- git: git@github.com:nwtgck/open-union-sugar-haskell.git
  commit: e45a481c9dd5d5b92b38b20b6e42a65f8b4ea1e3
...
```


## Usage

### `l` quote

```hs
{-# LANGUAGE QuasiQuotes #-}


import Data.OpenUnion
import Data.OpenUnion.Sugar

main :: IO ()
main = do
    let u1 :: Union '[Int, String]
        u1 = [l|"hello"|]
    print u1
    -- => Union ("hello" :: [Char])
```

### `hlist` quote

```hs
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}


import Data.OpenUnion
import Data.OpenUnion.Sugar

main :: IO ()
main = do
    let hlist1 :: [Union '[Char, Bool, String]]
        hlist1 = [hlist|
                    'a'
                  , True
                  , "apple"
                  , 'z'
                  , False
                  , "orange"
                 |]
    print hlist1
    -- => [Union ('a' :: Char),Union (True :: Bool),Union ("apple" :: [Char]),Union ('z' :: Char),Union (False :: Bool),Union ("orange" :: [Char])]
```