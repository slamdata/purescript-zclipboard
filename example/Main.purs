module Main where

import Control.Monad.Eff
import DOM
import Data.Maybe
import Data.Tuple
import Debug.Trace
import Debug.Foreign
import Data.DOM.Simple.Types
import Data.DOM.Simple.Document
import Data.DOM.Simple.Window
import Data.DOM.Simple.Element
import Data.DOM.Simple.Events

import qualified Control.UI.ZClipboard as Z

onLoad :: forall e. (Eff (dom::DOM|e) Unit) -> Eff (dom :: DOM|e) Unit 
onLoad action = 
  addUIEventListener LoadEvent handler globalWindow
  where handler :: DOMEvent -> _
        handler _ = action

main = onLoad do
  mbCopy <- document globalWindow >>= getElementById "copy-button"
  mbText <- document globalWindow >>= getElementById "copy-source"
  case Tuple mbCopy mbText of
    Tuple Nothing _ -> pure unit
    Tuple _ Nothing -> pure unit
    Tuple (Just el) (Just src) -> void do

      Z.make el >>= Z.onCopy (\clipboard -> do
                                 val <- value src
                                 Z.setData "text/plain" val clipboard)

