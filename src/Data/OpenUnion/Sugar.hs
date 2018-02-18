{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}

module Data.OpenUnion.Sugar (
  l
, hlist
, ptn
) where

import Language.Haskell.TH
import Language.Haskell.TH.Quote
import Language.Haskell.TH.Syntax
import Language.Haskell.Meta
import Data.Foldable

import Data.OpenUnion

-- | Syntax sugar of liftUnion
l :: QuasiQuoter
l = QuasiQuoter {
        quoteExp = \s -> do
            let Right e = parseExp s
            [|Data.OpenUnion.liftUnion $(return e)|]
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = undefined
    }

-- | Syntax sugar for hetero list
hlist :: QuasiQuoter
hlist = QuasiQuoter {
        quoteExp = \s -> do
            let Right (ListE es) = parseExp ("[" ++ s ++ "]")
                hes              = [[|Data.OpenUnion.liftUnion $(return e)|] | e <- es]
            listE hes
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = undefined
        }

-- | Syntax sugar for pattern
ptn :: QuasiQuoter
ptn   = QuasiQuoter {
        quoteExp = undefined
        , quotePat = undefined
        , quoteType = undefined
        , quoteDec = \s ->
                       case parseDecs s of
                         Right decs -> do
                           let f :: Dec -> DecQ
                               f (FunD name clauses) = valD (varP name) (normalB exp) []
                                 where clauseToLamE (Clause pats (NormalB exp) decs) = (lamE (fmap return pats) (return exp))
                                       lamEs           = fmap clauseToLamE clauses
                                       typesExhaustedE = [|Data.OpenUnion.typesExhausted|]
                                       exp             = foldr (\e s -> [|$(e) @> $(s)|]) typesExhaustedE lamEs
                               f other               =  return other
                           mapM f decs
                         Left e -> error ("Sugar error: " ++ e)
        }