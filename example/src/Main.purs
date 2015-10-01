module Main where

import Control.Monad.Eff (Eff())
import DOM (DOM())
import DOM.Event.EventTarget (addEventListener, eventListener)
import DOM.Event.EventTypes (load)
import DOM.Event.Types (Event())
import DOM.HTML (window)
import DOM.HTML.Types (windowToEventTarget, htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Element (getAttribute)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (Element(), ElementId(..), documentToNonElementParentNode)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Nullable (toMaybe)
import Prelude

import qualified Control.UI.ZClipboard as Z

foreign import value :: forall e. Element -> Eff (dom :: DOM|e) String

onLoad :: forall e. (Eff (dom::DOM|e) Unit) -> Eff (dom :: DOM|e) Unit
onLoad action =
  window >>= windowToEventTarget
  >>> addEventListener load (eventListener listener) false
  where
  listener :: Event -> Eff _ Unit
  listener _ = action

main = onLoad do
  win <- window
  doc <- map (documentToNonElementParentNode <<< htmlDocumentToDocument)
         $ document win

  mbCopy <- map toMaybe $ getElementById (ElementId "copy-button") doc
  mbText <- map toMaybe $ getElementById (ElementId "copy-source") doc
  run mbCopy mbText

run :: Maybe Element -> Maybe Element -> Eff _ Unit
run Nothing _ = pure unit
run _ Nothing = pure unit
run (Just el) (Just src) = void do
  Z.make el >>= Z.onCopy (\clipboard -> do
                             val <- value src
                             Z.setData "text/plain" val clipboard)
