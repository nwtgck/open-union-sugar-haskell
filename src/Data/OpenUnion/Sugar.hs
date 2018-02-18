{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}

module Data.OpenUnion.Sugar (
  l,
  hlist
) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Syntax
import Language.Haskell.Meta

-- | Syntax sugar of liftUnion
l :: QuasiQuoter
l = QuasiQuoter {
        quoteExp = \s -> do
            let Right e = parseExp s
            appE (varE $ mkName ("Data.OpenUnion.liftUnion") ) (return e)
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = undefined
    }

-- | Syntax sugar for hetero list
hlist :: QuasiQuoter
hlist = QuasiQuoter {
        quoteExp = \s -> do
            let Right (ListE es) = parseExp ("[" ++ s ++ "]")
                hes              = [appE (varE $ mkName ("Data.OpenUnion.liftUnion") ) (return e) | e <- es]
            listE hes
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = undefined
        }