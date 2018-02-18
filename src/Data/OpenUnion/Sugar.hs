{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}

module Data.OpenUnion.Sugar where

import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Syntax
import Language.Haskell.Meta

-- | Syntax sugar of liftUnion
l :: QuasiQuoter
l = QuasiQuoter {
        quoteExp = \s -> do
            let e = lift s :: Q Exp
            let Right e1 = parseExp s
            appE (varE $ mkName ("Data.OpenUnion.liftUnion") ) (return e1)
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = undefined
    }