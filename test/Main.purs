module Test.Main where

import Prelude

import Cache (db, host, port, getConn)
import Control.Monad.Aff (launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Options ((:=))
import Debug.Trace (spy)
import RedisLeader (isLeader, joinElection)
import Control.Monad.Eff.Class (liftEff)

main :: forall e. Eff _ Unit
main = do
  _ <- launchAff do
                  conn <- getConn (host := "127.0.0.1" <> port := 6379 <> db := 0)
                  _ <- liftEff $ joinElection conn
                  -- status <- isLeader conn
                  pure unit
  pure unit
