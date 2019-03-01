module RedisLeader where

import Prelude


import Data.Either (Either(..))
import Data.Foreign (isNull, toForeign)
import Data.Options (Options)
import Data.Array ((!!))
import Data.Maybe (Maybe(..))

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Exception (Error)
import Control.Monad.Eff.Timer (IntervalId, setInterval, setTimeout)
import Control.Monad.Aff (Aff, launchAff)
import Control.Monad.Aff.Console (log)


import Cache (getMulti, setMulti, getKeyMulti, exec, expire, CacheConn, CACHE) as C



foreign import getIPAdderess :: forall e. Eff e String
foreign import ipToNumber :: String -> String
foreign import numberToIP :: String -> String
foreign import getPID :: forall e. Eff e String

joinElection :: C.CacheConn -> Eff _ Unit
joinElection conn = (pure unit) <* setInterval 1000 do
                        pure unit <* launchAff do
                          ip <- liftEff getIPAdderess
                          pid <- liftEff getPID
                          address <- pure $ ip <> pid
                          value <- C.getMulti conn >>= C.setMulti ["leader", address, "NX", "PX", "2000"] >>= C.getKeyMulti "leader" >>= C.exec
                          case value of
                            Right x -> case x !! 0 of
                                          Just "OK" -> log "you got elected as the leader"
                                          Just _ -> case x !! 1 of
                                                      Just s -> if s == address then C.expire conn "leader" "2" *> log "you are still the leader" else log "you are not the leader"
                                                      Nothing -> log "exception :: redisValue !! 1 not present"
                                          Nothing -> log "exception :: redisValue !! 0 not present"
                            Left x -> (log <<< show) x

isLeader :: forall e. C.CacheConn -> Aff (cache :: C.CACHE | e) Boolean
isLeader conn = pure false

isWorker :: forall e. C.CacheConn -> Aff (cache :: C.CACHE | e) Boolean
isWorker conn = isLeader conn >>= (pure <<< not)

runRole :: C.CacheConn -> Aff _ Unit -> Aff _ Unit ->  Eff _ Unit
runRole conn l w = (pure unit) <* launchAff do
  isL <- isLeader conn 
  if isL then l else w


