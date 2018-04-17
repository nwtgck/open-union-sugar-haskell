# open-union-sugar

| branch | status|
| --- | --- |
| [`master`](https://github.com/nwtgck/open-union-sugar-haskell/tree/master) | [![Build Status](https://travis-ci.org/nwtgck/open-union-sugar-haskell.svg?branch=master)](https://travis-ci.org/nwtgck/open-union-sugar-haskell) |
| [`develop`](https://github.com/nwtgck/open-union-sugar-haskell/tree/develop) | [![Build Status](https://travis-ci.org/nwtgck/open-union-sugar-haskell.svg?branch=develop)](https://travis-ci.org/nwtgck/open-union-sugar-haskell) |

Syntactic sugar for [open-union](https://hackage.haskell.org/package/open-union)

## Install

### For [Stack](https://docs.haskellstack.org/en/stable/README/) users

Add this library to `extra-deps` in your `stack.yaml` like the following.

```yaml
...
extra-deps:
- git: https://github.com/nwtgck/open-union-sugar-haskell.git
  commit: 24ad5c35054dc511308bb5186cf17784042c499a
...
```

Then, add `open-union-sugar` to your `package.yaml` like the following.

```yaml
...
library:
 dependencies:
 - open-union-sugar
...
```

## Usage

### `l` quote

```hs
{-# LANGUAGE DataKinds #-}
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


### `ptn` quote

```hs
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE ScopedTypeVariables #-}

import Data.OpenUnion
import Data.OpenUnion.Sugar

type UnitList = [()]

showMyUnion :: Union '[Char, Int, String, UnitList] -> String
[ptn|
showMyUnion (c :: Char)     = "char: " ++ show c
showMyUnion (i :: Int)      = "int: " ++ show i
showMyUnion (s :: String)   = "string: " ++ s
showMyUnion (l :: UnitList) = "list length: " ++ show (length l)
|]


main :: IO ()
main = do
    let u1 :: Union '[Char, Int, String, UnitList]
        u1 = [l|"hello"|]
    putStrLn (showMyUnion u1)
    -- => string: hello

    let u2 :: Union '[Char, Int, String, UnitList]
        u2 = [l|189 :: Int|]
    putStrLn (showMyUnion u2)
    -- => int: 189
```