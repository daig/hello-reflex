{-# LANGUAGE OverloadedStrings #-}
module Main where
import Reflex.Dom.Core
import Language.Javascript.JSaddle.Warp (run)
import Control.Monad (forever)
import Control.Concurrent (threadDelay)
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = run 8000 (mainWidget app >> dontClose)
  where
    {-This is needed on ghc to prevent the main thread from terminating
     - after loading the page, and killing the warp websocket -}
    dontClose = forever (liftIO (threadDelay 1000000000))


app ::  MonadWidget t m => m ()
app = el "div" $ text "Hello, Reflex!"
