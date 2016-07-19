module Main where

import Prelude

import Control.Monad.Eff (Eff)

import Data.Maybe (Maybe(..))
import Data.Nullable (toMaybe)

import DOM (DOM)
import DOM.Event.EventTarget (addEventListener, eventListener)
import DOM.HTML (window)
import DOM.HTML.Event.EventTypes (load)
import DOM.HTML.Types (windowToEventTarget, htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (Element, ElementId(..), documentToNonElementParentNode)

import ZClipboard as Z

foreign import value :: forall eff. Element -> Eff (dom :: DOM | eff) String

onLoad :: forall eff. (Eff (dom :: DOM | eff) Unit) -> Eff (dom :: DOM | eff) Unit
onLoad action
  = addEventListener load (eventListener (const action)) false
  <<< windowToEventTarget
  =<< window

main :: forall eff. Eff (dom :: DOM, zClipboard :: Z.ZCLIPBOARD | eff) Unit
main = onLoad do
  win <- window
  doc <- documentToNonElementParentNode <<< htmlDocumentToDocument <$> document win
  mbCopy <- toMaybe <$> getElementById (ElementId "copy-button") doc
  mbText <- toMaybe <$> getElementById (ElementId "copy-source") doc
  case mbCopy, mbText of
    Just el, Just src ->
      void $
        Z.make el >>= Z.onCopy \clipboard -> do
          val <- value src
          Z.setData "text/plain" val clipboard
    _, _ -> pure unit
