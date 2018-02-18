{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}


import Data.OpenUnion
import Data.OpenUnion.Sugar

main :: IO ()
main = do
    -- TODO: Move them to a file OOOSpec file
    let u1 :: Union '[Int, String]
        u1 = [l|"hello"|]
    print u1

    let u2 :: Union '[Int, String]
        u2 = [l|205 :: Int|]
    print u2
