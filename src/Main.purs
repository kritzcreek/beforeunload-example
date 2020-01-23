module Main where

import Prelude

import Data.Foldable (for_)
import Effect (Effect)
import Web.Event.Event (preventDefault)
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML (window)
import Web.HTML.Event.BeforeUnloadEvent as BeforeUnloadEvent
import Web.HTML.Event.BeforeUnloadEvent.EventTypes (beforeunload)
import Web.HTML.Window as Window

main :: Effect Unit
main = do
  window <- window
  myListener <- eventListener \ev -> do
    for_ (BeforeUnloadEvent.fromEvent ev) \unloadEvent -> do
      preventDefault (BeforeUnloadEvent.toEvent unloadEvent)
      BeforeUnloadEvent.setReturnValue "" unloadEvent
  addEventListener beforeunload myListener true (Window.toEventTarget window)
  pure unit
