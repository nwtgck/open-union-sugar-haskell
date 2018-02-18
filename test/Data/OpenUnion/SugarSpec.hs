{-# LANGUAGE DataKinds #-}
{-# LANGUAGE QuasiQuotes #-}

module Data.OpenUnion.SugarSpec where

import Test.Hspec
import Test.QuickCheck
import Test.Hspec.QuickCheck

import Data.OpenUnion
import Data.OpenUnion.Sugar

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "l quote" $ do
    it "liftUnion" $ do
      let u1 :: Union '[Int, String]
          u1 = [l|"hello"|]
      u1 `shouldBe` liftUnion "hello"

      let u2 :: Union '[Int, String]
          u2 = [l|205 :: Int|]
      u2 `shouldBe` liftUnion (205 :: Int)


    describe "hlist quote" $ do
      it "hlist" $ do
        let hlist1 :: [Union '[Char, Bool, String]]
            hlist1 = [hlist|
                        'a'
                      , True
                      , "apple"
                      , 'z'
                      , False
                      , "orange"
                     |]
            expect = [liftUnion 'a', liftUnion True, liftUnion "apple", liftUnion 'z', liftUnion False, liftUnion "orange"]
        hlist1 `shouldBe` expect
